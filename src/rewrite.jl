export Rewriter, rewrite


replace(t::Union{Variable,AbstractTerm}) = Base.Fix1(replace, t)


struct Rewriter <: AbstractRewriter
    rewriters::Dict{AbstractTheory,AbstractRewriter}
    Rewriter() = new(Dict{AbstractTheory,AbstractRewriter}())
end
Rewriter(rs...) = push!(Rewriter(), rs...)

function Base.push!(rw::Rewriter, (p, b)::Pair{Term})
    th = theory(p)
    haskey(rw.rewriters, th) || (rw.rewriters[th] = rewriter(th))
    push!(rw.rewriters[th], p.t => b)
    rw
end

rewrite(rw::Rewriter) = Base.Fix1(rewrite, rw)
function rewrite(rw::Rewriter, t::AbstractTerm)
    while true
        th = theory(t)
        t = map(rewrite(rw), t)
        haskey(rw.rewriters, th) || return t

        t′ = rewrite(rw.rewriters[th], t)
        t′ === nothing && return t
        t = t′
    end
end
