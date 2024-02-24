using Plots;
using DifferentialEquations;

function new_equations(du, u, p, t)
    du[1] = -0.41*u[1] - 0.89*u[2] + sin(t + 7) + 1
    du[2] = -0.52*u[1] - 0.61*u[2] + cos(t + 6) + 1
end

const initial_conditions = Float64[61100, 45400]
const parameters = [0.0, 3.0]

problem = ODEProblem(new_equations, initial_conditions, parameters)
solution = solve(problem, dtmax=0.1)

X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi = 300, legend= true, bg =:white)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 1", legend=:outerbottom)
plot!(plot_solution, time, X_population, label="Численность армии X", color =:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color =:green)

savefig(plot_solution, "case1.png")