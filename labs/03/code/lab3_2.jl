using Plots
using DifferentialEquations

function new_equations(du, u, p, t)
    du[1] = -0.37*u[1] - 0.675*u[2] + abs(2*sin(t))
    du[2] = -0.432*u[1]*u[2] - 0.42*u[2] + cos(t) + 2
end

const initial_conditions = Float64[61100, 45400]
const parameters = [0.0, 0.0007]

problem = ODEProblem(new_equations, initial_conditions, parameters)
solution = solve(problem, dtmax=0.000001)

X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi=1200, legend=true, bg=:white)
plot!(plot_solution, time, X_population, label="Численность армии X", color=:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color=:green)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 2", legend=:outerbottom)

savefig(plot_solution, "case2.png")
