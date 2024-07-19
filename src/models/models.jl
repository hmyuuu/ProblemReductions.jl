"""
    AbstractProblem

The abstract base type of computational problems.
"""
abstract type AbstractProblem end

######## Interfaces for computational problems ##########
"""
    parameters(problem::AbstractProblem) -> Vector

The parameters of the computational problem.
"""
function parameters end

"""
    set_parameters(problem::AbstractProblem, parameters) -> AbstractProblem

Change the parameters for the `problem` and return a new problem instance.
"""
function set_parameters end

"""
    variables(problem::AbstractProblem) -> Vector

The degrees of freedoms in the computational problem. e.g. for the maximum independent set problems, they are the indices of vertices: 1, 2, 3...,
while for the max cut problem, they are the edges.
"""
function variables end

"""
    num_variables(problem::AbstractProblem) -> Int

The number of variables in the computational problem.
"""
num_variables(c::AbstractProblem) = length(variables(c))

"""
    parameter_type(problem::AbstractProblem) -> Type

The data type of the parameters in the computational problem.
"""
parameter_type(gp::AbstractProblem) = eltype(parameters(gp))

"""
    flavors(::Type{<:AbstractProblem}) -> Vector

Returns a vector of integers as the flavors (domain) of a degree of freedom.
"""
flavors(::GT) where GT<:AbstractProblem = flavors(GT)

"""
    num_flavors(::Type{<:AbstractProblem}) -> Int

Returns the number of flavors (domain) of a degree of freedom.
"""
num_flavors(::GT) where GT<:AbstractProblem = length(flavors(GT))

"""
    evaluate(problem::AbstractProblem, config) -> Real

Evaluate the energy of the `problem` given the configuration `config`.
The lower the energy, the better the configuration.
"""
function evaluate end

"""
    findbest(problem::AbstractProblem, method) -> Vector

Find the best configurations of the `problem` using the `method`.
"""
function findbest end

struct UnitWeight <: AbstractVector{Int}
    n::Int
end
Base.getindex(::UnitWeight, i) = 1
Base.size(w::UnitWeight) = (w.n,)


include("SpinGlass.jl")
include("Circuit.jl")
include("Coloring.jl")
include("Satisfiability.jl")
include("SetCovering.jl")
include("MaxCut.jl")
