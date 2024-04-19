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

function sanitise_yaml(str)
    str = replace(str, r"␣" => " ")
    str = replace(str, r"∎" => "")
    str = replace(str, r"↵" => "")
    str = replace(str, r"←" => "\r")
    str = replace(str, r"⇔" => "\uFEFE")
    str = replace(str, r"—*»" => "\t")
    return str
end
function each_yaml_str(file)
    output = []
    for each in LibYAML.load_file(file), document in each
        push!(output, sanitise_yaml(document["yaml"]))
    end
    return output
end

@testset "LibYAML" begin
    @test LibYAML.version() == v"0.2.5"

    @testset "yaml-test-suite" begin
        skipped = Set([
            # TODO: Skipped test cases.
            "26DV.yaml",
            "2JQS.yaml",
            "2LFX.yaml",
            "2SXE.yaml",
            "4ABK.yaml",
            "4EJS.yaml",
            "4MUZ.yaml",
            "58MP.yaml",
            "5MUD.yaml",
            "5T43.yaml",
            "6BCT.yaml",
            "6CA3.yaml",
            "6KGN.yaml",
            "6LVF.yaml",
            "6M2F.yaml",
            "7Z25.yaml",
            "8XYN.yaml",
            "96NN.yaml",
            "9C9N.yaml",
            "9HCY.yaml",
            "9JBA.yaml",
            "9SA2.yaml",
            "A2M4.yaml",
            "BEC7.yaml",
            "C4HZ.yaml",
            "CFD4.yaml",
            "CUP7.yaml",
            "CVW2.yaml",
            "DBG4.yaml",
            "DK3J.yaml",
            "DK95.yaml",
            "EB22.yaml",
            "FP8R.yaml",
            "FRK4.yaml",
            "G5U8.yaml",
            "HM87.yaml",
            "HMQ5.yaml",
            "HWV9.yaml",
            "JS2J.yaml",
            "K3WX.yaml",
            "M2N8.yaml",
            "M7A3.yaml",
            "MUS6.yaml",
            "NHX8.yaml",
            "NJ66.yaml",
            "NKF9.yaml",
            "Q5MG.yaml",
            "QB6E.yaml",
            "QT73.yaml",
            "R4YG.yaml",
            "RHX7.yaml",
            "S3PD.yaml",
            "S98Z.yaml",
            "SM9W.yaml",
            "SU5Z.yaml",
            "UGM3.yaml",
            "UKK6.yaml",
            "UT92.yaml",
            "VJP3.yaml",
            "W4TN.yaml",
            "W5VH.yaml",
            "X4QW.yaml",
            "Y79Y.yaml",
            "YJV2.yaml",
            "ZYU8.yaml",
        ])
        currently_broken = Set([
        # TODO: broken test cases.
        ])
        @test isempty(intersect(skipped, currently_broken))

        yaml_test_suite_src = joinpath(yaml_test_suite, "src")
        for (root, dirs, files) in walkdir(yaml_test_suite_src), file in files
            path = joinpath(root, file)
            if endswith(path, ".yaml")
                @testset "$path" begin
                    for document in LibYAML.load_file(path), value in document
                        fail = get(value, "fail", false)
                        yaml = sanitise_yaml(value["yaml"])

                        # TODO: ensure all test cases pass, and don't skip any.
                        if file in currently_broken
                            @test_broken try
                                result = LibYAML.load(yaml)
                                true
                            catch error
                                false
                            end
                        elseif file in skipped
                            @test_broken false
                        else
                            if fail === false
                                LibYAML.load(yaml)
                            else
                                @test_throws LibYAML.ParserError LibYAML.load(yaml)
                            end
                        end
                    end
                end
            end
        end
    end
end
