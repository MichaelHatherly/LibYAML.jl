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

function _parse_yaml_str(text::AbstractString)
    parser = Ref{C_API.yaml_parser_s}()
    event = Ref{C_API.yaml_event_s}()
    C_API.yaml_parser_initialize(parser)
    text = string(text)
    len = ncodeunits(text)
    C_API.yaml_parser_set_input_string(parser, text, len)
    try
        return _handle_events(parser, event, [])
    finally
        C_API.yaml_event_delete(event)
        C_API.yaml_parser_delete(parser)
    end
end

function _handle_events(parser, event, acc)
    while true
        C_API.yaml_parser_parse(parser, event) == 0 &&
            throw(YAMLParserError("Failed to parse YAML"))

        type = event[].type
        if type == C_API.YAML_NO_EVENT
        elseif type == C_API.YAML_STREAM_START_EVENT
        elseif type == C_API.YAML_STREAM_END_EVENT
            return acc
        elseif type == C_API.YAML_DOCUMENT_START_EVENT
        elseif type == C_API.YAML_DOCUMENT_END_EVENT
        elseif type == C_API.YAML_ALIAS_EVENT
        elseif type == C_API.YAML_SCALAR_EVENT
            scalar = event[].data.scalar
            push!(acc, unsafe_string(scalar.value, scalar.length))
        elseif type == C_API.YAML_MAPPING_START_EVENT
            push!(acc, _handle_events(parser, event, []))
        elseif type == C_API.YAML_MAPPING_END_EVENT
            count = length(acc)
            iseven(count) || error("unreachable reached, expected even number in mapping.")
            mapping = Dict{Any,Any}()
            for (k, v) in Iterators.partition(acc, 2)
                haskey(mapping, k) && error("Map keys must be unique: $k")
                mapping[k] = v
            end
            return mapping
        elseif type == C_API.YAML_SEQUENCE_START_EVENT
            push!(acc, _handle_events(parser, event, []))
        elseif type == C_API.YAML_SEQUENCE_END_EVENT
            return acc
        end
    end
end

end
