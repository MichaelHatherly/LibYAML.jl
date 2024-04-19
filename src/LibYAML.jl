module LibYAML

module API

using LibYAML_jll

include("libyaml_api.jl")

end

"""
    version() -> VersionNumber

Get the version of the LibYAML library used by this package.
"""
version() = VersionNumber(unsafe_string(API.yaml_get_version_string()))

end
