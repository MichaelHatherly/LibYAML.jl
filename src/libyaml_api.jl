using CEnum

function yaml_get_version_string()
    @ccall libyaml.yaml_get_version_string()::Ptr{Cchar}
end

function yaml_get_version(major, minor, patch)
    @ccall libyaml.yaml_get_version(major::Ptr{Cint}, minor::Ptr{Cint}, patch::Ptr{Cint})::Cvoid
end

const yaml_char_t = Cuchar

struct yaml_version_directive_s
    major::Cint
    minor::Cint
end

const yaml_version_directive_t = yaml_version_directive_s

struct yaml_tag_directive_s
    handle::Ptr{yaml_char_t}
    prefix::Ptr{yaml_char_t}
end

const yaml_tag_directive_t = yaml_tag_directive_s

@cenum yaml_encoding_e::UInt32 begin
    YAML_ANY_ENCODING = 0
    YAML_UTF8_ENCODING = 1
    YAML_UTF16LE_ENCODING = 2
    YAML_UTF16BE_ENCODING = 3
end

const yaml_encoding_t = yaml_encoding_e

@cenum yaml_break_e::UInt32 begin
    YAML_ANY_BREAK = 0
    YAML_CR_BREAK = 1
    YAML_LN_BREAK = 2
    YAML_CRLN_BREAK = 3
end

const yaml_break_t = yaml_break_e

@cenum yaml_error_type_e::UInt32 begin
    YAML_NO_ERROR = 0
    YAML_MEMORY_ERROR = 1
    YAML_READER_ERROR = 2
    YAML_SCANNER_ERROR = 3
    YAML_PARSER_ERROR = 4
    YAML_COMPOSER_ERROR = 5
    YAML_WRITER_ERROR = 6
    YAML_EMITTER_ERROR = 7
end

const yaml_error_type_t = yaml_error_type_e

struct yaml_mark_s
    index::Csize_t
    line::Csize_t
    column::Csize_t
end

const yaml_mark_t = yaml_mark_s

@cenum yaml_scalar_style_e::UInt32 begin
    YAML_ANY_SCALAR_STYLE = 0
    YAML_PLAIN_SCALAR_STYLE = 1
    YAML_SINGLE_QUOTED_SCALAR_STYLE = 2
    YAML_DOUBLE_QUOTED_SCALAR_STYLE = 3
    YAML_LITERAL_SCALAR_STYLE = 4
    YAML_FOLDED_SCALAR_STYLE = 5
end

const yaml_scalar_style_t = yaml_scalar_style_e

@cenum yaml_sequence_style_e::UInt32 begin
    YAML_ANY_SEQUENCE_STYLE = 0
    YAML_BLOCK_SEQUENCE_STYLE = 1
    YAML_FLOW_SEQUENCE_STYLE = 2
end

const yaml_sequence_style_t = yaml_sequence_style_e

@cenum yaml_mapping_style_e::UInt32 begin
    YAML_ANY_MAPPING_STYLE = 0
    YAML_BLOCK_MAPPING_STYLE = 1
    YAML_FLOW_MAPPING_STYLE = 2
end

const yaml_mapping_style_t = yaml_mapping_style_e

@cenum yaml_token_type_e::UInt32 begin
    YAML_NO_TOKEN = 0
    YAML_STREAM_START_TOKEN = 1
    YAML_STREAM_END_TOKEN = 2
    YAML_VERSION_DIRECTIVE_TOKEN = 3
    YAML_TAG_DIRECTIVE_TOKEN = 4
    YAML_DOCUMENT_START_TOKEN = 5
    YAML_DOCUMENT_END_TOKEN = 6
    YAML_BLOCK_SEQUENCE_START_TOKEN = 7
    YAML_BLOCK_MAPPING_START_TOKEN = 8
    YAML_BLOCK_END_TOKEN = 9
    YAML_FLOW_SEQUENCE_START_TOKEN = 10
    YAML_FLOW_SEQUENCE_END_TOKEN = 11
    YAML_FLOW_MAPPING_START_TOKEN = 12
    YAML_FLOW_MAPPING_END_TOKEN = 13
    YAML_BLOCK_ENTRY_TOKEN = 14
    YAML_FLOW_ENTRY_TOKEN = 15
    YAML_KEY_TOKEN = 16
    YAML_VALUE_TOKEN = 17
    YAML_ALIAS_TOKEN = 18
    YAML_ANCHOR_TOKEN = 19
    YAML_TAG_TOKEN = 20
    YAML_SCALAR_TOKEN = 21
end

const yaml_token_type_t = yaml_token_type_e

struct __JL_Ctag_45
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_45}, f::Symbol)
    f === :stream_start && return Ptr{__JL_Ctag_46}(x + 0)
    f === :alias && return Ptr{__JL_Ctag_47}(x + 0)
    f === :anchor && return Ptr{__JL_Ctag_48}(x + 0)
    f === :tag && return Ptr{__JL_Ctag_49}(x + 0)
    f === :scalar && return Ptr{__JL_Ctag_50}(x + 0)
    f === :version_directive && return Ptr{__JL_Ctag_51}(x + 0)
    f === :tag_directive && return Ptr{__JL_Ctag_52}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_45, f::Symbol)
    r = Ref{__JL_Ctag_45}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_45}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_45}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct yaml_token_s
    data::NTuple{80, UInt8}
end

function Base.getproperty(x::Ptr{yaml_token_s}, f::Symbol)
    f === :type && return Ptr{yaml_token_type_t}(x + 0)
    f === :data && return Ptr{__JL_Ctag_45}(x + 8)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 32)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 56)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_token_s, f::Symbol)
    r = Ref{yaml_token_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_token_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_token_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_token_t = yaml_token_s

function yaml_token_delete(token)
    @ccall libyaml.yaml_token_delete(token::Ptr{yaml_token_t})::Cvoid
end

@cenum yaml_event_type_e::UInt32 begin
    YAML_NO_EVENT = 0
    YAML_STREAM_START_EVENT = 1
    YAML_STREAM_END_EVENT = 2
    YAML_DOCUMENT_START_EVENT = 3
    YAML_DOCUMENT_END_EVENT = 4
    YAML_ALIAS_EVENT = 5
    YAML_SCALAR_EVENT = 6
    YAML_SEQUENCE_START_EVENT = 7
    YAML_SEQUENCE_END_EVENT = 8
    YAML_MAPPING_START_EVENT = 9
    YAML_MAPPING_END_EVENT = 10
end

const yaml_event_type_t = yaml_event_type_e

struct __JL_Ctag_30
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_30}, f::Symbol)
    f === :stream_start && return Ptr{__JL_Ctag_31}(x + 0)
    f === :document_start && return Ptr{Cvoid}(x + 0)
    f === :document_end && return Ptr{__JL_Ctag_34}(x + 0)
    f === :alias && return Ptr{__JL_Ctag_35}(x + 0)
    f === :scalar && return Ptr{__JL_Ctag_36}(x + 0)
    f === :sequence_start && return Ptr{__JL_Ctag_37}(x + 0)
    f === :mapping_start && return Ptr{__JL_Ctag_38}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_30, f::Symbol)
    r = Ref{__JL_Ctag_30}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_30}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_30}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct yaml_event_s
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{yaml_event_s}, f::Symbol)
    f === :type && return Ptr{yaml_event_type_t}(x + 0)
    f === :data && return Ptr{__JL_Ctag_30}(x + 8)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 56)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 80)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_event_s, f::Symbol)
    r = Ref{yaml_event_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_event_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_event_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_event_t = yaml_event_s

function yaml_stream_start_event_initialize(event, encoding)
    @ccall libyaml.yaml_stream_start_event_initialize(event::Ptr{yaml_event_t}, encoding::yaml_encoding_t)::Cint
end

function yaml_stream_end_event_initialize(event)
    @ccall libyaml.yaml_stream_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

function yaml_document_start_event_initialize(event, version_directive, tag_directives_start, tag_directives_end, implicit)
    @ccall libyaml.yaml_document_start_event_initialize(event::Ptr{yaml_event_t}, version_directive::Ptr{yaml_version_directive_t}, tag_directives_start::Ptr{yaml_tag_directive_t}, tag_directives_end::Ptr{yaml_tag_directive_t}, implicit::Cint)::Cint
end

function yaml_document_end_event_initialize(event, implicit)
    @ccall libyaml.yaml_document_end_event_initialize(event::Ptr{yaml_event_t}, implicit::Cint)::Cint
end

function yaml_alias_event_initialize(event, anchor)
    @ccall libyaml.yaml_alias_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t})::Cint
end

function yaml_scalar_event_initialize(event, anchor, tag, value, length, plain_implicit, quoted_implicit, style)
    @ccall libyaml.yaml_scalar_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, value::Ptr{yaml_char_t}, length::Cint, plain_implicit::Cint, quoted_implicit::Cint, style::yaml_scalar_style_t)::Cint
end

function yaml_sequence_start_event_initialize(event, anchor, tag, implicit, style)
    @ccall libyaml.yaml_sequence_start_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, implicit::Cint, style::yaml_sequence_style_t)::Cint
end

function yaml_sequence_end_event_initialize(event)
    @ccall libyaml.yaml_sequence_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

function yaml_mapping_start_event_initialize(event, anchor, tag, implicit, style)
    @ccall libyaml.yaml_mapping_start_event_initialize(event::Ptr{yaml_event_t}, anchor::Ptr{yaml_char_t}, tag::Ptr{yaml_char_t}, implicit::Cint, style::yaml_mapping_style_t)::Cint
end

function yaml_mapping_end_event_initialize(event)
    @ccall libyaml.yaml_mapping_end_event_initialize(event::Ptr{yaml_event_t})::Cint
end

function yaml_event_delete(event)
    @ccall libyaml.yaml_event_delete(event::Ptr{yaml_event_t})::Cvoid
end

@cenum yaml_node_type_e::UInt32 begin
    YAML_NO_NODE = 0
    YAML_SCALAR_NODE = 1
    YAML_SEQUENCE_NODE = 2
    YAML_MAPPING_NODE = 3
end

const yaml_node_type_t = yaml_node_type_e

struct __JL_Ctag_39
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_39}, f::Symbol)
    f === :scalar && return Ptr{__JL_Ctag_40}(x + 0)
    f === :sequence && return Ptr{Cvoid}(x + 0)
    f === :mapping && return Ptr{Cvoid}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_39, f::Symbol)
    r = Ref{__JL_Ctag_39}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_39}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_39}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct yaml_node_s
    data::NTuple{96, UInt8}
end

function Base.getproperty(x::Ptr{yaml_node_s}, f::Symbol)
    f === :type && return Ptr{yaml_node_type_t}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :data && return Ptr{__JL_Ctag_39}(x + 16)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 48)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 72)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_node_s, f::Symbol)
    r = Ref{yaml_node_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_node_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_node_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_node_t = yaml_node_s

const yaml_node_item_t = Cint

struct yaml_node_pair_s
    key::Cint
    value::Cint
end

const yaml_node_pair_t = yaml_node_pair_s

struct __JL_Ctag_28
    start::Ptr{yaml_node_t}
    _end::Ptr{yaml_node_t}
    top::Ptr{yaml_node_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_28}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_28, f::Symbol)
    r = Ref{__JL_Ctag_28}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_28}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_28}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_29
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_29}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_29, f::Symbol)
    r = Ref{__JL_Ctag_29}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_29}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_29}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct yaml_document_s
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{yaml_document_s}, f::Symbol)
    f === :nodes && return Ptr{__JL_Ctag_28}(x + 0)
    f === :version_directive && return Ptr{Ptr{yaml_version_directive_t}}(x + 24)
    f === :tag_directives && return Ptr{__JL_Ctag_29}(x + 32)
    f === :start_implicit && return Ptr{Cint}(x + 48)
    f === :end_implicit && return Ptr{Cint}(x + 52)
    f === :start_mark && return Ptr{yaml_mark_t}(x + 56)
    f === :end_mark && return Ptr{yaml_mark_t}(x + 80)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_document_s, f::Symbol)
    r = Ref{yaml_document_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_document_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_document_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_document_t = yaml_document_s

function yaml_document_initialize(document, version_directive, tag_directives_start, tag_directives_end, start_implicit, end_implicit)
    @ccall libyaml.yaml_document_initialize(document::Ptr{yaml_document_t}, version_directive::Ptr{yaml_version_directive_t}, tag_directives_start::Ptr{yaml_tag_directive_t}, tag_directives_end::Ptr{yaml_tag_directive_t}, start_implicit::Cint, end_implicit::Cint)::Cint
end

function yaml_document_delete(document)
    @ccall libyaml.yaml_document_delete(document::Ptr{yaml_document_t})::Cvoid
end

function yaml_document_get_node(document, index)
    @ccall libyaml.yaml_document_get_node(document::Ptr{yaml_document_t}, index::Cint)::Ptr{yaml_node_t}
end

function yaml_document_get_root_node(document)
    @ccall libyaml.yaml_document_get_root_node(document::Ptr{yaml_document_t})::Ptr{yaml_node_t}
end

function yaml_document_add_scalar(document, tag, value, length, style)
    @ccall libyaml.yaml_document_add_scalar(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, value::Ptr{yaml_char_t}, length::Cint, style::yaml_scalar_style_t)::Cint
end

function yaml_document_add_sequence(document, tag, style)
    @ccall libyaml.yaml_document_add_sequence(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, style::yaml_sequence_style_t)::Cint
end

function yaml_document_add_mapping(document, tag, style)
    @ccall libyaml.yaml_document_add_mapping(document::Ptr{yaml_document_t}, tag::Ptr{yaml_char_t}, style::yaml_mapping_style_t)::Cint
end

function yaml_document_append_sequence_item(document, sequence, item)
    @ccall libyaml.yaml_document_append_sequence_item(document::Ptr{yaml_document_t}, sequence::Cint, item::Cint)::Cint
end

function yaml_document_append_mapping_pair(document, mapping, key, value)
    @ccall libyaml.yaml_document_append_mapping_pair(document::Ptr{yaml_document_t}, mapping::Cint, key::Cint, value::Cint)::Cint
end

# typedef int yaml_read_handler_t ( void * data , unsigned char * buffer , size_t size , size_t * size_read )
const yaml_read_handler_t = Cvoid

struct yaml_simple_key_s
    possible::Cint
    required::Cint
    token_number::Csize_t
    mark::yaml_mark_t
end

const yaml_simple_key_t = yaml_simple_key_s

@cenum yaml_parser_state_e::UInt32 begin
    YAML_PARSE_STREAM_START_STATE = 0
    YAML_PARSE_IMPLICIT_DOCUMENT_START_STATE = 1
    YAML_PARSE_DOCUMENT_START_STATE = 2
    YAML_PARSE_DOCUMENT_CONTENT_STATE = 3
    YAML_PARSE_DOCUMENT_END_STATE = 4
    YAML_PARSE_BLOCK_NODE_STATE = 5
    YAML_PARSE_BLOCK_NODE_OR_INDENTLESS_SEQUENCE_STATE = 6
    YAML_PARSE_FLOW_NODE_STATE = 7
    YAML_PARSE_BLOCK_SEQUENCE_FIRST_ENTRY_STATE = 8
    YAML_PARSE_BLOCK_SEQUENCE_ENTRY_STATE = 9
    YAML_PARSE_INDENTLESS_SEQUENCE_ENTRY_STATE = 10
    YAML_PARSE_BLOCK_MAPPING_FIRST_KEY_STATE = 11
    YAML_PARSE_BLOCK_MAPPING_KEY_STATE = 12
    YAML_PARSE_BLOCK_MAPPING_VALUE_STATE = 13
    YAML_PARSE_FLOW_SEQUENCE_FIRST_ENTRY_STATE = 14
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_STATE = 15
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_KEY_STATE = 16
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_VALUE_STATE = 17
    YAML_PARSE_FLOW_SEQUENCE_ENTRY_MAPPING_END_STATE = 18
    YAML_PARSE_FLOW_MAPPING_FIRST_KEY_STATE = 19
    YAML_PARSE_FLOW_MAPPING_KEY_STATE = 20
    YAML_PARSE_FLOW_MAPPING_VALUE_STATE = 21
    YAML_PARSE_FLOW_MAPPING_EMPTY_VALUE_STATE = 22
    YAML_PARSE_END_STATE = 23
end

const yaml_parser_state_t = yaml_parser_state_e

struct yaml_alias_data_s
    anchor::Ptr{yaml_char_t}
    index::Cint
    mark::yaml_mark_t
end

const yaml_alias_data_t = yaml_alias_data_s

struct __JL_Ctag_17
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_17}, f::Symbol)
    f === :string && return Ptr{__JL_Ctag_18}(x + 0)
    f === :file && return Ptr{Ptr{Libc.FILE}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_17, f::Symbol)
    r = Ref{__JL_Ctag_17}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_17}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_17}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct __JL_Ctag_19
    start::Ptr{yaml_char_t}
    _end::Ptr{yaml_char_t}
    pointer::Ptr{yaml_char_t}
    last::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_19}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :pointer && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :last && return Ptr{Ptr{yaml_char_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_19, f::Symbol)
    r = Ref{__JL_Ctag_19}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_19}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_19}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_20
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    pointer::Ptr{Cuchar}
    last::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_20}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :pointer && return Ptr{Ptr{Cuchar}}(x + 16)
    f === :last && return Ptr{Ptr{Cuchar}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_20, f::Symbol)
    r = Ref{__JL_Ctag_20}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_20}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_20}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_21
    start::Ptr{yaml_token_t}
    _end::Ptr{yaml_token_t}
    head::Ptr{yaml_token_t}
    tail::Ptr{yaml_token_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_21}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_token_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_token_t}}(x + 8)
    f === :head && return Ptr{Ptr{yaml_token_t}}(x + 16)
    f === :tail && return Ptr{Ptr{yaml_token_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_21, f::Symbol)
    r = Ref{__JL_Ctag_21}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_21}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_21}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_22
    start::Ptr{Cint}
    _end::Ptr{Cint}
    top::Ptr{Cint}
end
function Base.getproperty(x::Ptr{__JL_Ctag_22}, f::Symbol)
    f === :start && return Ptr{Ptr{Cint}}(x + 0)
    f === :_end && return Ptr{Ptr{Cint}}(x + 8)
    f === :top && return Ptr{Ptr{Cint}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_22, f::Symbol)
    r = Ref{__JL_Ctag_22}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_22}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_22}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_23
    start::Ptr{yaml_simple_key_t}
    _end::Ptr{yaml_simple_key_t}
    top::Ptr{yaml_simple_key_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_23}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_simple_key_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_simple_key_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_simple_key_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_23, f::Symbol)
    r = Ref{__JL_Ctag_23}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_23}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_23}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_24
    start::Ptr{yaml_parser_state_t}
    _end::Ptr{yaml_parser_state_t}
    top::Ptr{yaml_parser_state_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_24}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_parser_state_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_parser_state_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_parser_state_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_24, f::Symbol)
    r = Ref{__JL_Ctag_24}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_24}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_24}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_25
    start::Ptr{yaml_mark_t}
    _end::Ptr{yaml_mark_t}
    top::Ptr{yaml_mark_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_25}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_mark_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_mark_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_mark_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_25, f::Symbol)
    r = Ref{__JL_Ctag_25}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_25}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_25}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_26
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
    top::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_26}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_tag_directive_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_26, f::Symbol)
    r = Ref{__JL_Ctag_26}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_26}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_26}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_27
    start::Ptr{yaml_alias_data_t}
    _end::Ptr{yaml_alias_data_t}
    top::Ptr{yaml_alias_data_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_27}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_alias_data_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_alias_data_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_alias_data_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_27, f::Symbol)
    r = Ref{__JL_Ctag_27}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_27}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_27}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct yaml_parser_s
    data::NTuple{480, UInt8}
end

function Base.getproperty(x::Ptr{yaml_parser_s}, f::Symbol)
    f === :error && return Ptr{yaml_error_type_t}(x + 0)
    f === :problem && return Ptr{Ptr{Cchar}}(x + 8)
    f === :problem_offset && return Ptr{Csize_t}(x + 16)
    f === :problem_value && return Ptr{Cint}(x + 24)
    f === :problem_mark && return Ptr{yaml_mark_t}(x + 32)
    f === :context && return Ptr{Ptr{Cchar}}(x + 56)
    f === :context_mark && return Ptr{yaml_mark_t}(x + 64)
    f === :read_handler && return Ptr{Ptr{yaml_read_handler_t}}(x + 88)
    f === :read_handler_data && return Ptr{Ptr{Cvoid}}(x + 96)
    f === :input && return Ptr{__JL_Ctag_17}(x + 104)
    f === :eof && return Ptr{Cint}(x + 128)
    f === :buffer && return Ptr{__JL_Ctag_19}(x + 136)
    f === :unread && return Ptr{Csize_t}(x + 168)
    f === :raw_buffer && return Ptr{__JL_Ctag_20}(x + 176)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 208)
    f === :offset && return Ptr{Csize_t}(x + 216)
    f === :mark && return Ptr{yaml_mark_t}(x + 224)
    f === :stream_start_produced && return Ptr{Cint}(x + 248)
    f === :stream_end_produced && return Ptr{Cint}(x + 252)
    f === :flow_level && return Ptr{Cint}(x + 256)
    f === :tokens && return Ptr{__JL_Ctag_21}(x + 264)
    f === :tokens_parsed && return Ptr{Csize_t}(x + 296)
    f === :token_available && return Ptr{Cint}(x + 304)
    f === :indents && return Ptr{__JL_Ctag_22}(x + 312)
    f === :indent && return Ptr{Cint}(x + 336)
    f === :simple_key_allowed && return Ptr{Cint}(x + 340)
    f === :simple_keys && return Ptr{__JL_Ctag_23}(x + 344)
    f === :states && return Ptr{__JL_Ctag_24}(x + 368)
    f === :state && return Ptr{yaml_parser_state_t}(x + 392)
    f === :marks && return Ptr{__JL_Ctag_25}(x + 400)
    f === :tag_directives && return Ptr{__JL_Ctag_26}(x + 424)
    f === :aliases && return Ptr{__JL_Ctag_27}(x + 448)
    f === :document && return Ptr{Ptr{yaml_document_t}}(x + 472)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_parser_s, f::Symbol)
    r = Ref{yaml_parser_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_parser_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_parser_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_parser_t = yaml_parser_s

function yaml_parser_initialize(parser)
    @ccall libyaml.yaml_parser_initialize(parser::Ptr{yaml_parser_t})::Cint
end

function yaml_parser_delete(parser)
    @ccall libyaml.yaml_parser_delete(parser::Ptr{yaml_parser_t})::Cvoid
end

function yaml_parser_set_input_string(parser, input, size)
    @ccall libyaml.yaml_parser_set_input_string(parser::Ptr{yaml_parser_t}, input::Ptr{Cuchar}, size::Csize_t)::Cvoid
end

function yaml_parser_set_input_file(parser, file)
    @ccall libyaml.yaml_parser_set_input_file(parser::Ptr{yaml_parser_t}, file::Ptr{Libc.FILE})::Cvoid
end

function yaml_parser_set_input(parser, handler, data)
    @ccall libyaml.yaml_parser_set_input(parser::Ptr{yaml_parser_t}, handler::Ptr{yaml_read_handler_t}, data::Ptr{Cvoid})::Cvoid
end

function yaml_parser_set_encoding(parser, encoding)
    @ccall libyaml.yaml_parser_set_encoding(parser::Ptr{yaml_parser_t}, encoding::yaml_encoding_t)::Cvoid
end

function yaml_parser_scan(parser, token)
    @ccall libyaml.yaml_parser_scan(parser::Ptr{yaml_parser_t}, token::Ptr{yaml_token_t})::Cint
end

function yaml_parser_parse(parser, event)
    @ccall libyaml.yaml_parser_parse(parser::Ptr{yaml_parser_t}, event::Ptr{yaml_event_t})::Cint
end

function yaml_parser_load(parser, document)
    @ccall libyaml.yaml_parser_load(parser::Ptr{yaml_parser_t}, document::Ptr{yaml_document_t})::Cint
end

# typedef int yaml_write_handler_t ( void * data , unsigned char * buffer , size_t size )
const yaml_write_handler_t = Cvoid

@cenum yaml_emitter_state_e::UInt32 begin
    YAML_EMIT_STREAM_START_STATE = 0
    YAML_EMIT_FIRST_DOCUMENT_START_STATE = 1
    YAML_EMIT_DOCUMENT_START_STATE = 2
    YAML_EMIT_DOCUMENT_CONTENT_STATE = 3
    YAML_EMIT_DOCUMENT_END_STATE = 4
    YAML_EMIT_FLOW_SEQUENCE_FIRST_ITEM_STATE = 5
    YAML_EMIT_FLOW_SEQUENCE_ITEM_STATE = 6
    YAML_EMIT_FLOW_MAPPING_FIRST_KEY_STATE = 7
    YAML_EMIT_FLOW_MAPPING_KEY_STATE = 8
    YAML_EMIT_FLOW_MAPPING_SIMPLE_VALUE_STATE = 9
    YAML_EMIT_FLOW_MAPPING_VALUE_STATE = 10
    YAML_EMIT_BLOCK_SEQUENCE_FIRST_ITEM_STATE = 11
    YAML_EMIT_BLOCK_SEQUENCE_ITEM_STATE = 12
    YAML_EMIT_BLOCK_MAPPING_FIRST_KEY_STATE = 13
    YAML_EMIT_BLOCK_MAPPING_KEY_STATE = 14
    YAML_EMIT_BLOCK_MAPPING_SIMPLE_VALUE_STATE = 15
    YAML_EMIT_BLOCK_MAPPING_VALUE_STATE = 16
    YAML_EMIT_END_STATE = 17
end

const yaml_emitter_state_t = yaml_emitter_state_e

struct yaml_anchors_s
    references::Cint
    anchor::Cint
    serialized::Cint
end

const yaml_anchors_t = yaml_anchors_s

struct __JL_Ctag_6
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_6}, f::Symbol)
    f === :string && return Ptr{__JL_Ctag_7}(x + 0)
    f === :file && return Ptr{Ptr{Libc.FILE}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_6, f::Symbol)
    r = Ref{__JL_Ctag_6}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_6}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_6}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct __JL_Ctag_8
    start::Ptr{yaml_char_t}
    _end::Ptr{yaml_char_t}
    pointer::Ptr{yaml_char_t}
    last::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_8}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :pointer && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :last && return Ptr{Ptr{yaml_char_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_8, f::Symbol)
    r = Ref{__JL_Ctag_8}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_8}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_8}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_9
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    pointer::Ptr{Cuchar}
    last::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_9}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :pointer && return Ptr{Ptr{Cuchar}}(x + 16)
    f === :last && return Ptr{Ptr{Cuchar}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_9, f::Symbol)
    r = Ref{__JL_Ctag_9}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_9}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_9}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_10
    start::Ptr{yaml_emitter_state_t}
    _end::Ptr{yaml_emitter_state_t}
    top::Ptr{yaml_emitter_state_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_10}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_emitter_state_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_emitter_state_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_emitter_state_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_10, f::Symbol)
    r = Ref{__JL_Ctag_10}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_10}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_10}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_11
    start::Ptr{yaml_event_t}
    _end::Ptr{yaml_event_t}
    head::Ptr{yaml_event_t}
    tail::Ptr{yaml_event_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_11}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_event_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_event_t}}(x + 8)
    f === :head && return Ptr{Ptr{yaml_event_t}}(x + 16)
    f === :tail && return Ptr{Ptr{yaml_event_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_11, f::Symbol)
    r = Ref{__JL_Ctag_11}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_11}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_11}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_12
    start::Ptr{Cint}
    _end::Ptr{Cint}
    top::Ptr{Cint}
end
function Base.getproperty(x::Ptr{__JL_Ctag_12}, f::Symbol)
    f === :start && return Ptr{Ptr{Cint}}(x + 0)
    f === :_end && return Ptr{Ptr{Cint}}(x + 8)
    f === :top && return Ptr{Ptr{Cint}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_12, f::Symbol)
    r = Ref{__JL_Ctag_12}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_12}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_12}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_13
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
    top::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_13}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_tag_directive_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_13, f::Symbol)
    r = Ref{__JL_Ctag_13}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_13}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_13}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_14
    anchor::Ptr{yaml_char_t}
    anchor_length::Csize_t
    alias::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_14}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :anchor_length && return Ptr{Csize_t}(x + 8)
    f === :alias && return Ptr{Cint}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_14, f::Symbol)
    r = Ref{__JL_Ctag_14}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_14}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_14}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_15
    handle::Ptr{yaml_char_t}
    handle_length::Csize_t
    suffix::Ptr{yaml_char_t}
    suffix_length::Csize_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_15}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :handle_length && return Ptr{Csize_t}(x + 8)
    f === :suffix && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :suffix_length && return Ptr{Csize_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_15, f::Symbol)
    r = Ref{__JL_Ctag_15}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_15}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_15}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_16
    value::Ptr{yaml_char_t}
    length::Csize_t
    multiline::Cint
    flow_plain_allowed::Cint
    block_plain_allowed::Cint
    single_quoted_allowed::Cint
    block_allowed::Cint
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_16}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :multiline && return Ptr{Cint}(x + 16)
    f === :flow_plain_allowed && return Ptr{Cint}(x + 20)
    f === :block_plain_allowed && return Ptr{Cint}(x + 24)
    f === :single_quoted_allowed && return Ptr{Cint}(x + 28)
    f === :block_allowed && return Ptr{Cint}(x + 32)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_16, f::Symbol)
    r = Ref{__JL_Ctag_16}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_16}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_16}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct yaml_emitter_s
    data::NTuple{432, UInt8}
end

function Base.getproperty(x::Ptr{yaml_emitter_s}, f::Symbol)
    f === :error && return Ptr{yaml_error_type_t}(x + 0)
    f === :problem && return Ptr{Ptr{Cchar}}(x + 8)
    f === :write_handler && return Ptr{Ptr{yaml_write_handler_t}}(x + 16)
    f === :write_handler_data && return Ptr{Ptr{Cvoid}}(x + 24)
    f === :output && return Ptr{__JL_Ctag_6}(x + 32)
    f === :buffer && return Ptr{__JL_Ctag_8}(x + 56)
    f === :raw_buffer && return Ptr{__JL_Ctag_9}(x + 88)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 120)
    f === :canonical && return Ptr{Cint}(x + 124)
    f === :best_indent && return Ptr{Cint}(x + 128)
    f === :best_width && return Ptr{Cint}(x + 132)
    f === :unicode && return Ptr{Cint}(x + 136)
    f === :line_break && return Ptr{yaml_break_t}(x + 140)
    f === :states && return Ptr{__JL_Ctag_10}(x + 144)
    f === :state && return Ptr{yaml_emitter_state_t}(x + 168)
    f === :events && return Ptr{__JL_Ctag_11}(x + 176)
    f === :indents && return Ptr{__JL_Ctag_12}(x + 208)
    f === :tag_directives && return Ptr{__JL_Ctag_13}(x + 232)
    f === :indent && return Ptr{Cint}(x + 256)
    f === :flow_level && return Ptr{Cint}(x + 260)
    f === :root_context && return Ptr{Cint}(x + 264)
    f === :sequence_context && return Ptr{Cint}(x + 268)
    f === :mapping_context && return Ptr{Cint}(x + 272)
    f === :simple_key_context && return Ptr{Cint}(x + 276)
    f === :line && return Ptr{Cint}(x + 280)
    f === :column && return Ptr{Cint}(x + 284)
    f === :whitespace && return Ptr{Cint}(x + 288)
    f === :indention && return Ptr{Cint}(x + 292)
    f === :open_ended && return Ptr{Cint}(x + 296)
    f === :anchor_data && return Ptr{__JL_Ctag_14}(x + 304)
    f === :tag_data && return Ptr{__JL_Ctag_15}(x + 328)
    f === :scalar_data && return Ptr{__JL_Ctag_16}(x + 360)
    f === :opened && return Ptr{Cint}(x + 400)
    f === :closed && return Ptr{Cint}(x + 404)
    f === :anchors && return Ptr{Ptr{yaml_anchors_t}}(x + 408)
    f === :last_anchor_id && return Ptr{Cint}(x + 416)
    f === :document && return Ptr{Ptr{yaml_document_t}}(x + 424)
    return getfield(x, f)
end

function Base.getproperty(x::yaml_emitter_s, f::Symbol)
    r = Ref{yaml_emitter_s}(x)
    ptr = Base.unsafe_convert(Ptr{yaml_emitter_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{yaml_emitter_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const yaml_emitter_t = yaml_emitter_s

function yaml_emitter_initialize(emitter)
    @ccall libyaml.yaml_emitter_initialize(emitter::Ptr{yaml_emitter_t})::Cint
end

function yaml_emitter_delete(emitter)
    @ccall libyaml.yaml_emitter_delete(emitter::Ptr{yaml_emitter_t})::Cvoid
end

function yaml_emitter_set_output_string(emitter, output, size, size_written)
    @ccall libyaml.yaml_emitter_set_output_string(emitter::Ptr{yaml_emitter_t}, output::Ptr{Cuchar}, size::Csize_t, size_written::Ptr{Csize_t})::Cvoid
end

function yaml_emitter_set_output_file(emitter, file)
    @ccall libyaml.yaml_emitter_set_output_file(emitter::Ptr{yaml_emitter_t}, file::Ptr{Libc.FILE})::Cvoid
end

function yaml_emitter_set_output(emitter, handler, data)
    @ccall libyaml.yaml_emitter_set_output(emitter::Ptr{yaml_emitter_t}, handler::Ptr{yaml_write_handler_t}, data::Ptr{Cvoid})::Cvoid
end

function yaml_emitter_set_encoding(emitter, encoding)
    @ccall libyaml.yaml_emitter_set_encoding(emitter::Ptr{yaml_emitter_t}, encoding::yaml_encoding_t)::Cvoid
end

function yaml_emitter_set_canonical(emitter, canonical)
    @ccall libyaml.yaml_emitter_set_canonical(emitter::Ptr{yaml_emitter_t}, canonical::Cint)::Cvoid
end

function yaml_emitter_set_indent(emitter, indent)
    @ccall libyaml.yaml_emitter_set_indent(emitter::Ptr{yaml_emitter_t}, indent::Cint)::Cvoid
end

function yaml_emitter_set_width(emitter, width)
    @ccall libyaml.yaml_emitter_set_width(emitter::Ptr{yaml_emitter_t}, width::Cint)::Cvoid
end

function yaml_emitter_set_unicode(emitter, unicode)
    @ccall libyaml.yaml_emitter_set_unicode(emitter::Ptr{yaml_emitter_t}, unicode::Cint)::Cvoid
end

function yaml_emitter_set_break(emitter, line_break)
    @ccall libyaml.yaml_emitter_set_break(emitter::Ptr{yaml_emitter_t}, line_break::yaml_break_t)::Cvoid
end

function yaml_emitter_emit(emitter, event)
    @ccall libyaml.yaml_emitter_emit(emitter::Ptr{yaml_emitter_t}, event::Ptr{yaml_event_t})::Cint
end

function yaml_emitter_open(emitter)
    @ccall libyaml.yaml_emitter_open(emitter::Ptr{yaml_emitter_t})::Cint
end

function yaml_emitter_close(emitter)
    @ccall libyaml.yaml_emitter_close(emitter::Ptr{yaml_emitter_t})::Cint
end

function yaml_emitter_dump(emitter, document)
    @ccall libyaml.yaml_emitter_dump(emitter::Ptr{yaml_emitter_t}, document::Ptr{yaml_document_t})::Cint
end

function yaml_emitter_flush(emitter)
    @ccall libyaml.yaml_emitter_flush(emitter::Ptr{yaml_emitter_t})::Cint
end

struct __JL_Ctag_7
    buffer::Ptr{Cuchar}
    size::Csize_t
    size_written::Ptr{Csize_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_7}, f::Symbol)
    f === :buffer && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :size && return Ptr{Csize_t}(x + 8)
    f === :size_written && return Ptr{Ptr{Csize_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_7, f::Symbol)
    r = Ref{__JL_Ctag_7}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_7}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_7}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_18
    start::Ptr{Cuchar}
    _end::Ptr{Cuchar}
    current::Ptr{Cuchar}
end
function Base.getproperty(x::Ptr{__JL_Ctag_18}, f::Symbol)
    f === :start && return Ptr{Ptr{Cuchar}}(x + 0)
    f === :_end && return Ptr{Ptr{Cuchar}}(x + 8)
    f === :current && return Ptr{Ptr{Cuchar}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_18, f::Symbol)
    r = Ref{__JL_Ctag_18}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_18}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_18}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_31
    encoding::yaml_encoding_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_31}, f::Symbol)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_31, f::Symbol)
    r = Ref{__JL_Ctag_31}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_31}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_31}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_33
    start::Ptr{yaml_tag_directive_t}
    _end::Ptr{yaml_tag_directive_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_33}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_tag_directive_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_tag_directive_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_33, f::Symbol)
    r = Ref{__JL_Ctag_33}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_33}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_33}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_32
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_32}, f::Symbol)
    f === :version_directive && return Ptr{Ptr{yaml_version_directive_t}}(x + 0)
    f === :tag_directives && return Ptr{__JL_Ctag_33}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_32, f::Symbol)
    r = Ref{__JL_Ctag_32}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_32}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_32}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct __JL_Ctag_34
    implicit::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_34}, f::Symbol)
    f === :implicit && return Ptr{Cint}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_34, f::Symbol)
    r = Ref{__JL_Ctag_34}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_34}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_34}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_35
    anchor::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_35}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_35, f::Symbol)
    r = Ref{__JL_Ctag_35}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_35}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_35}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_36
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    value::Ptr{yaml_char_t}
    length::Csize_t
    plain_implicit::Cint
    quoted_implicit::Cint
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_36}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 16)
    f === :length && return Ptr{Csize_t}(x + 24)
    f === :plain_implicit && return Ptr{Cint}(x + 32)
    f === :quoted_implicit && return Ptr{Cint}(x + 36)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_36, f::Symbol)
    r = Ref{__JL_Ctag_36}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_36}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_36}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_37
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    implicit::Cint
    style::yaml_sequence_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_37}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 16)
    f === :style && return Ptr{yaml_sequence_style_t}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_37, f::Symbol)
    r = Ref{__JL_Ctag_37}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_37}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_37}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_38
    anchor::Ptr{yaml_char_t}
    tag::Ptr{yaml_char_t}
    implicit::Cint
    style::yaml_mapping_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_38}, f::Symbol)
    f === :anchor && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :tag && return Ptr{Ptr{yaml_char_t}}(x + 8)
    f === :implicit && return Ptr{Cint}(x + 16)
    f === :style && return Ptr{yaml_mapping_style_t}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_38, f::Symbol)
    r = Ref{__JL_Ctag_38}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_38}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_38}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_40
    value::Ptr{yaml_char_t}
    length::Csize_t
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_40}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_40, f::Symbol)
    r = Ref{__JL_Ctag_40}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_40}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_40}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_42
    start::Ptr{yaml_node_item_t}
    _end::Ptr{yaml_node_item_t}
    top::Ptr{yaml_node_item_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_42}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_item_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_item_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_item_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_42, f::Symbol)
    r = Ref{__JL_Ctag_42}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_42}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_42}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_41
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_41}, f::Symbol)
    f === :items && return Ptr{__JL_Ctag_42}(x + 0)
    f === :style && return Ptr{yaml_sequence_style_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_41, f::Symbol)
    r = Ref{__JL_Ctag_41}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_41}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_41}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct __JL_Ctag_44
    start::Ptr{yaml_node_pair_t}
    _end::Ptr{yaml_node_pair_t}
    top::Ptr{yaml_node_pair_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_44}, f::Symbol)
    f === :start && return Ptr{Ptr{yaml_node_pair_t}}(x + 0)
    f === :_end && return Ptr{Ptr{yaml_node_pair_t}}(x + 8)
    f === :top && return Ptr{Ptr{yaml_node_pair_t}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_44, f::Symbol)
    r = Ref{__JL_Ctag_44}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_44}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_44}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_43
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{__JL_Ctag_43}, f::Symbol)
    f === :pairs && return Ptr{__JL_Ctag_44}(x + 0)
    f === :style && return Ptr{yaml_mapping_style_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_43, f::Symbol)
    r = Ref{__JL_Ctag_43}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_43}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_43}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct __JL_Ctag_46
    encoding::yaml_encoding_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_46}, f::Symbol)
    f === :encoding && return Ptr{yaml_encoding_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_46, f::Symbol)
    r = Ref{__JL_Ctag_46}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_46}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_46}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_47
    value::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_47}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_47, f::Symbol)
    r = Ref{__JL_Ctag_47}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_47}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_47}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_48
    value::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_48}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_48, f::Symbol)
    r = Ref{__JL_Ctag_48}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_48}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_48}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_49
    handle::Ptr{yaml_char_t}
    suffix::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_49}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :suffix && return Ptr{Ptr{yaml_char_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_49, f::Symbol)
    r = Ref{__JL_Ctag_49}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_49}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_49}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_50
    value::Ptr{yaml_char_t}
    length::Csize_t
    style::yaml_scalar_style_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_50}, f::Symbol)
    f === :value && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :length && return Ptr{Csize_t}(x + 8)
    f === :style && return Ptr{yaml_scalar_style_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_50, f::Symbol)
    r = Ref{__JL_Ctag_50}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_50}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_50}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_51
    major::Cint
    minor::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_51}, f::Symbol)
    f === :major && return Ptr{Cint}(x + 0)
    f === :minor && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_51, f::Symbol)
    r = Ref{__JL_Ctag_51}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_51}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_51}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_52
    handle::Ptr{yaml_char_t}
    prefix::Ptr{yaml_char_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_52}, f::Symbol)
    f === :handle && return Ptr{Ptr{yaml_char_t}}(x + 0)
    f === :prefix && return Ptr{Ptr{yaml_char_t}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_52, f::Symbol)
    r = Ref{__JL_Ctag_52}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_52}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_52}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const YAML_NULL_TAG = "tag:yaml.org,2002:null"

const YAML_BOOL_TAG = "tag:yaml.org,2002:bool"

const YAML_STR_TAG = "tag:yaml.org,2002:str"

const YAML_INT_TAG = "tag:yaml.org,2002:int"

const YAML_FLOAT_TAG = "tag:yaml.org,2002:float"

const YAML_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp"

const YAML_SEQ_TAG = "tag:yaml.org,2002:seq"

const YAML_MAP_TAG = "tag:yaml.org,2002:map"

const YAML_DEFAULT_SCALAR_TAG = YAML_STR_TAG

const YAML_DEFAULT_SEQUENCE_TAG = YAML_SEQ_TAG

const YAML_DEFAULT_MAPPING_TAG = YAML_MAP_TAG

