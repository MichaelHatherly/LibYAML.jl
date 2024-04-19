using LibYAML
using Test

yaml_test_suite = joinpath(@__DIR__, "yaml-test-suite")
let yaml_test_suite_commit = "45db50aecf9b1520f8258938c88f396e96f30831"
    if isdir(yaml_test_suite)
        cd(yaml_test_suite) do
            run(`git fetch`)
        end
    else
        run(`git clone https://github.com/yaml/yaml-test-suite`)
    end
    cd(yaml_test_suite) do
        run(`git checkout $yaml_test_suite_commit`)
    end
end

@testset "LibYAML" begin
    @test LibYAML.version() == v"0.2.5"

    @testset "yaml-test-suite" begin
        yaml_test_suite_src = joinpath(yaml_test_suite, "src")
        for (root, dirs, files) in walkdir(yaml_test_suite_src), file in files
            path = joinpath(root, file)
            if endswith(path, ".yaml")
                @testset "$path" begin
                    LibYAML.load_file(path)
                end
            end
        end
    end
end
