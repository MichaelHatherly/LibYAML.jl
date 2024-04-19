using LibYAML
using Test

@testset "LibYAML" begin
    @test LibYAML.version() == v"0.2.5"
end
