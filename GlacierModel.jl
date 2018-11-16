module GlacierModel

import RecipesBase.@recipe
import Base.==

export Ellipse, area, ==

"""
This is the documentation for the Ellipse
"""
struct Ellipse
    a::Float64  #semimajor axis
    b::Float64  #semiminor axis
    θ₀::Float64 #angle of ellipse in radians
    function Ellipse(a::Real,b::Real,theta::Real)
        a>0 || throw(ArgumentError("The parameter a must be positive"))
        b>0 || throw(ArgumentError("The parameter b must be positive"))
        new(a,b,theta)
    end
end

struct EllipseDataset
    angle::Array{Float64,1}
    strain::Array{Float64,1}
    function EllipseDataset(a::Array{Float64,1},st::Array{Float64,1})
        length(a) == length(st) || throw(ArgumentError("The two arrays must have the same length"))
        new(a,st)
    end
end

function ==(el1::Ellipse,el2::Ellipse)
   isapprox(el1.a,el2.a) && isapprox(el1.b,el2.b) && isapprox(mod(el1.θ₀,pi),mod(el2.θ₀,pi)) ||
   isapprox(el1.a,el2.b) && isapprox(el1.b,el2.a) && isapprox(mod(abs(el1.θ₀-el2.θ₀),pi),pi/2) 
end

@recipe function f(el::Ellipse)
  seriestype --> :path
  aspect_ratio --> 1
  println(el.θ₀)
  theta = LinRange(0,2*pi,200)
  r(th::Number) = sqrt(1/(cos(th)^2/el.a^2+sin(th)^2/el.b^2))
  x = map(th->r(th-el.θ₀)*cos(th),theta)
  y = map(th->r(th-el.θ₀)*sin(th),theta)
  x,y
end

function area(el::Ellipse)
    pi*el.a*el.b
end



end # module Ellipse