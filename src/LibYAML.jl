module LibYAML

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
    load(text::AbstractString) -> YAML

Load a YAML string and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values.
"""
load(text::AbstractString) = _parse_yaml_str(text)

"""
    load_file(filename::AbstractString) -> YAML

Load a YAML file and return the parsed data. The data is returned as a nested
structure of `Vector`s, `Dict`s, and scalar values.
"""
load_file(filename::AbstractString) = load(read(filename, String))

struct ParserError <: Exception
    message::String
end

function _parse_yaml_str(text::AbstractString)
    parser = Ref{C_API.yaml_parser_s}()
    event = Ref{C_API.yaml_event_s}()
    C_API.yaml_parser_initialize(parser)
    text = string(text)
    len = ncodeunits(text)
    C_API.yaml_parser_set_input_string(parser, text, len)
    try
        return _handle_events(parser, event, [], Dict())
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
            _handle_events(parser, event, acc, Dict())
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
    mapping = _handle_events(parser, event, [], aliases)
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
    seq = _handle_events(parser, event, [], aliases)
    aliases[anchor] = seq
    return seq
end

function _get_alias(event::Ref{C_API.yaml_event_s}, aliases::Dict)
    key = unsafe_string(event[].data.alias.anchor)
    return Ref(aliases[key])
end

_get_anchor(obj) = obj.anchor == C_NULL ? nothing : unsafe_string(obj.anchor)

end
