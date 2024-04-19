import Pkg
import Pkg.Artifacts
import Clang.Generators
import Clang.Generators.JLLEnvs
import LibYAML_jll
import JuliaFormatter

cd(@__DIR__) do
    include_dir = normpath(joinpath(LibYAML_jll.artifact_dir, "include"))

    yaml_h = joinpath(include_dir, "yaml.h")
    @assert isfile(yaml_h)

    options = Generators.load_options(joinpath(@__DIR__, "generator.toml"))

    args = Generators.get_default_args()
    push!(args, "-I$include_dir")

    header_files = [yaml_h]

    ctx = Generators.create_context(header_files, args, options)

    Generators.build!(ctx)
end
