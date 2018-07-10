@hl type MasterColumn <: MasterVar
    solution::Solution

    # ```
    # Determines whether this column was generated by a subproblem with the 
    # "enumerated" status. This flag may have an impact on the column 
    # coefficients in master cuts.
    # ```
    enumerated_flag::Bool

    # ```
    # Flag telling whether or not the column is part of the convexity constraint.
    # ```
    belongs_to_convexity_constraint::Bool
end

function MasterColumnBuilder(problem::P, sp_sol::Solution,
                             name::String) where P
    return tuplejoin(MasterVarBuilder(problem, 
            string(name, problem.VarConstrCounter.value), 0.0, 'P',
            spSol.type, 'd', -1, 0.0, Inf, 'U', spSol.priority), spSol, 
            0, 0 #= enumeration not supported =#, spSol.countAsSolution, true)
end
