using Plots
using DifferentialEquations

x0 = 4
y0 = 12
u0 = [x0; y0]
t0 = 0
tmax = 200
tspan = (t0, tmax)
t = collect(LinRange(t0, tmax, 1000))
    
a = 0.71
b = 0.046
c = 0.64
d = 0.017

function syst(dy, y, p, t)
    dy[1] = -a*y[1] + b*y[1]*y[2]
    dy[2] = c*y[2] - d*y[1]*y[2]
end

prob = ODEProblem(syst, u0, tspan)
sol = solve(prob, saveat = t)

plot(sol)
savefig("../report/image/01_jl.png")

plot(sol, idxs=(1, 2))
savefig("../report/image/02_jl.png")
