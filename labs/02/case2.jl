using DifferentialEquations
using Plots

const n = 16.9
const v = 4.7
const r = n / (v - 1)
const t1 = (-pi, pi)

function F(u, p, t)
    return u / sqrt(v*v - 1)
end

setup = ODEProblem(F, r, t1)
result = solve(setup, abstol=1e-8, reltol=1e-8)
index = rand(1:size(result.t)[1])
rAngles = [result.t[index] for i in 1:size(result.t)[1]]
plt = plot(proj=:polar, aspect_ratio=:equal, dpi = 1000, legend=true, bg=:white)
plot!(plt, [rAngles[1], rAngles[2]], [0.0, result.u[size(result.u)[1]]], label="Путь лодки", color=:red, lw=1)
scatter!(plt, rAngles, result.u, label="", mc=:red, ms=0.0005)
plot!(plt, result.t, result.u, xlabel="theta", ylabel="r(t)", label="Путь катера", color=:green, lw=1)
scatter!(plt, result.t, result.u, label="", mc=:green, ms=0.0005)
savefig(plt, "case2.png")