@hl mutable struct MasterColumn <: Variable
    solution::PrimalSolution

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

# function VariableBuilder(counter::VarConstrCounter, name::String, 
#         costrhs::Float, sense::Char, vc_type::Char, flag::Char, directive::Char, 
#         priority::Float, lowerBound::Float, upperBound::Float)

function MasterColumnBuilder(counter::VarConstrCounter, 
                             sp_sol::PrimalSolution) where P
    cost = compute_original_cost(sp_sol)
    return tuplejoin(VariableBuilder(counter, string("MC", counter.value), 
            cost, 'P', 'I', 'd', 'D', -1.0, 0.0, Inf), 
            sp_sol, false #= enumeration not supported =#, true)
         
    #TODO add membership using sp_sol        
end
