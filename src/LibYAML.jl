module LibYAML

export load
export load_file
export load_all
export load_all_file

module C_API

using LibYAML_jll

include("libyaml_api.jl")

end

"""
    version() -> VersionNumber

Get the version of the LibYAML library used by this package.
"""
version() = VersionNumber(unsafe_string(C_API.yaml_get_version_string()))

"""
    load(text::AbstractString; all = false) -> YAML

Load a YAML string and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values.
"""
load(text::AbstractString; all::Bool = false) = _parse_yaml_str(text, all)

"""
    load_all(text::AbstractString) -> Vector{YAML}

Load a YAML string and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values. This function is used when
the YAML string contains multiple documents.
"""
load_all(text::AbstractString) = load(text; all = true)

"""
    load_file(filename::AbstractString; all = false) -> YAML

Load a YAML file and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values.
"""
load_file(filename::AbstractString; all::Bool = false) = load(read(filename, String); all)

"""
    load_all_file(filename::AbstractString) -> Vector{YAML}

Load a YAML file and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values. This function is used when
the YAML file contains multiple documents.
"""
load_all_file(filename::AbstractString) = load_file(filename; all = true)

struct ParserError <: Exception
    message::String
end

function _parse_yaml_str(text::AbstractString, all_documents::Bool)
    parser = Ref{C_API.yaml_parser_s}()
    event = Ref{C_API.yaml_event_s}()
    C_API.yaml_parser_initialize(parser)
    text = string(text)
    len = ncodeunits(text)
    C_API.yaml_parser_set_input_string(parser, text, len)
    try
        return _handle_events(parser, event, [], Dict(), all_documents)
    finally
        C_API.yaml_event_delete(event)
        C_API.yaml_parser_delete(parser)
    end
end

function _handle_events(
    parser::Ref{C_API.yaml_parser_s},
    event::Ref{C_API.yaml_event_s},
    acc::Vector,
    aliases::Dict,
    all_documents::Bool,
)
    while true
        if C_API.yaml_parser_parse(parser, event) == 0
            # Clean up is performed in the caller's `finally` block which is
            # also where clean up occurs for normal return.
            throw(ParserError("Failed to parse YAML"))
        end

        type = event[].type

        if type == C_API.YAML_NO_EVENT
            # This appears to be the same code path as a parser error triggers.
            # Leave it empty for now and just deal with parse errors in the
            # separate `if` block above.

            # Streams.
        elseif type == C_API.YAML_STREAM_START_EVENT
            isempty(acc) || error("unreachable reached, expected empty accumulator.")
        elseif type == C_API.YAML_STREAM_END_EVENT
            return acc

            # Documents.
        elseif type == C_API.YAML_DOCUMENT_START_EVENT
            _handle_events(parser, event, acc, Dict(), all_documents)
            all_documents || return only(acc)
        elseif type == C_API.YAML_DOCUMENT_END_EVENT
            return acc

            # Aliases.
        elseif type == C_API.YAML_ALIAS_EVENT
            push!(acc, _get_alias(event, aliases))

            # Scalars.
        elseif type == C_API.YAML_SCALAR_EVENT
            push!(acc, _get_scalar(event, aliases))

            # Mappings.
        elseif type == C_API.YAML_MAPPING_START_EVENT
            push!(acc, _start_mapping(parser, event, aliases))
        elseif type == C_API.YAML_MAPPING_END_EVENT
            return _end_mapping(acc)

            # Sequences.
        elseif type == C_API.YAML_SEQUENCE_START_EVENT
            push!(acc, _start_sequence(parser, event, aliases))
        elseif type == C_API.YAML_SEQUENCE_END_EVENT
            return acc
        end
    end
end

function _get_scalar(event::Ref{C_API.yaml_event_s}, aliases::Dict)
    scalar = event[].data.scalar
    anchor = _get_anchor(scalar)
    value = unsafe_string(scalar.value, scalar.length)
    aliases[anchor] = value
    return value
end

function _start_mapping(
    parser::Ref{C_API.yaml_parser_s},
    event::Ref{C_API.yaml_event_s},
    aliases::Dict,
)
    anchor = _get_anchor(event[].data.mapping_start)
    mapping = _handle_events(parser, event, [], aliases, false)
    aliases[anchor] = mapping
    return mapping
end

function _end_mapping(acc::Vector)
    count = length(acc)
    iseven(count) || error("unreachable reached, expected even number in mapping.")
    mapping = Dict{Any,Any}()
    for (k, v) in Iterators.partition(acc, 2)
        mapping[k] = v
    end
    return mapping
end

function _start_sequence(
    parser::Ref{C_API.yaml_parser_s},
    event::Ref{C_API.yaml_event_s},
    aliases::Dict,
)
    anchor = _get_anchor(event[].data.sequence_start)
    seq = _handle_events(parser, event, [], aliases, false)
    aliases[anchor] = seq
    return seq
end

function _get_alias(event::Ref{C_API.yaml_event_s}, aliases::Dict)
    key = unsafe_string(event[].data.alias.anchor)
    return Ref(aliases[key])
end

_get_anchor(obj) = obj.anchor == C_NULL ? nothing : unsafe_string(obj.anchor)

# Writer:

struct EmitterError <: Exception
    message::String
end

dump(yaml::Any) = sprint(dump, yaml)
dump(io::IO, yaml::Any) = _dump_complete_yaml(io, yaml)

function _write_handler(data::Ptr{Cvoid}, buffer::Ptr{Cchar}, size::Csize_t)::Cint
    io = unsafe_pointer_to_objref(data)
    write(io, unsafe_string(buffer, size))
    return 1
end

function _dump_complete_yaml(io::IO, yaml::Any)
    emitter = Ref{C_API.yaml_emitter_s}()
    event = Ref{C_API.yaml_event_s}()
    C_API.yaml_emitter_initialize(emitter)
    try
        handler = @cfunction(_write_handler, Cint, (Ptr{Cvoid}, Ptr{Cchar}, Csize_t))
        C_API.yaml_emitter_set_output(emitter, handler, pointer_from_objref(io))

        C_API.yaml_stream_start_event_initialize(event, C_API.YAML_UTF8_ENCODING)
        if C_API.yaml_emitter_emit(emitter, event) == 0
            throw(EmitterError("Failed to emit stream start event"))
        end

        for document in yaml
            C_API.yaml_document_start_event_initialize(event, C_NULL, C_NULL, C_NULL, 1)
            if C_API.yaml_emitter_emit(emitter, event) == 0
                throw(EmitterError("Failed to emit document start event"))
            end

            _dump(emitter, event, document)

            C_API.yaml_document_end_event_initialize(event, 1)
            if C_API.yaml_emitter_emit(emitter, event) == 0
                throw(EmitterError("Failed to emit document end event"))
            end
        end

        C_API.yaml_stream_end_event_initialize(event)
        if C_API.yaml_emitter_emit(emitter, event) == 0
            throw(EmitterError("Failed to emit stream end event"))
        end
    finally
        C_API.yaml_emitter_delete(emitter)
        C_API.yaml_event_delete(event)
    end
end

function _dump(
    emitter::Ref{C_API.yaml_emitter_s},
    event::Ref{C_API.yaml_event_s},
    yaml::AbstractDict,
)
    C_API.yaml_mapping_start_event_initialize(
        event,
        C_NULL,
        C_NULL,
        1,
        C_API.YAML_BLOCK_MAPPING_STYLE,
    )
    if C_API.yaml_emitter_emit(emitter, event) == 0
        throw(EmitterError("Failed to emit mapping start event"))
    end

    for (k, v) in yaml
        _dump(emitter, event, k)
        _dump(emitter, event, v)
    end

    C_API.yaml_mapping_end_event_initialize(event)
    if C_API.yaml_emitter_emit(emitter, event) == 0
        throw(EmitterError("Failed to emit mapping end event"))
    end
end

function _dump(
    emitter::Ref{C_API.yaml_emitter_s},
    event::Ref{C_API.yaml_event_s},
    yaml::AbstractVector,
)
    C_API.yaml_sequence_start_event_initialize(
        event,
        C_NULL,
        C_NULL,
        1,
        C_API.YAML_BLOCK_SEQUENCE_STYLE,
    )
    if C_API.yaml_emitter_emit(emitter, event) == 0
        throw(EmitterError("Failed to emit sequence start event"))
    end

    for item in yaml
        _dump(emitter, event, item)
    end

    C_API.yaml_sequence_end_event_initialize(event)
    if C_API.yaml_emitter_emit(emitter, event) == 0
        throw(EmitterError("Failed to emit sequence end event"))
    end
end

function _dump(
    emitter::Ref{C_API.yaml_emitter_s},
    event::Ref{C_API.yaml_event_s},
    yaml::Union{AbstractString,Symbol},
)
    yaml = string(yaml)
    cstr = Base.unsafe_convert(Cstring, yaml)
    ptr = pointer(cstr)
    C_API.yaml_scalar_event_initialize(
        event,
        C_NULL,
        C_NULL,
        ptr,
        ncodeunits(yaml),
        1,
        1,
        C_API.YAML_PLAIN_SCALAR_STYLE,
    )
    if C_API.yaml_emitter_emit(emitter, event) == 0
        throw(EmitterError("Failed to emit scalar event"))
    end
end

function _dump(
    emitter::Ref{C_API.yaml_emitter_s},
    event::Ref{C_API.yaml_event_s},
    yaml::Any,
)
    return _dump(emitter, event, string(yaml))
end

end
