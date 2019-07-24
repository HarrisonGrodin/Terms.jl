using Terms
using Test


@theory! begin
    a => FreeTheory()
    b => FreeTheory()
    c => FreeTheory()
    f => FreeTheory()
    g => FreeTheory()
    h => FreeTheory()
    p => CTheory()
    q => CTheory()
end

a(xs...) = @term(a($(xs...)))
b(xs...) = @term(b($(xs...)))
c(xs...) = @term(c($(xs...)))
f(xs...) = @term(f($(xs...)))
g(xs...) = @term(g($(xs...)))
h(xs...) = @term(h($(xs...)))
p(x, y) = @term(p($x, $y))
q(x, y) = @term(q($x, $y))
x, y, z = Variable(), Variable(), Variable()


@testset "construction" begin
    include("construction.jl")
end

@testset "match" begin
    include("match.jl")
end

@testset "rewrite" begin
    include("rewrite.jl")
end
