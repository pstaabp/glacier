using .GlacierModel, Test


el1 = Ellipse(1,2,pi/4)
el2 = Ellipse(1,2,5*pi/4)
el3 = Ellipse(2,1,3*pi/4)


@testset "Create Ellipses" begin
    @test isa(Ellipse(1,2,pi/2),Ellipse)
    @test el1==el2
    @test el1==el3
end

@testset "Ellipse arguments" begin
    @test_throws ArgumentError Ellipse(-1,1,pi/4)
    @test_throws ArgumentError Ellipse(1,-1,pi/4)
end

@testset "Area of an Ellipse" begin
   @test isapprox(area(el1),2*pi)
end