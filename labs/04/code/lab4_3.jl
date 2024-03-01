using Plots
using DifferentialEquations

x0 = 0
y0 = -1.2
u0 = [x0, y0]
t0 = 0
tmax = 51
t = collect(LinRange(t0, tmax, 1000))
tspan = (t0, tmax)

w = 1
g = 12

function F(t)
    return 2*cos(0.5*t)
end

function lorenz(dy, y, p, t)
    dy[1] = y[2]
    dy[2] = -g*y[2] - w*y[1] + F(t)
end

prob = ODEProblem(lorenz, u0, tspan)
sol = solve(prob, saveat=t)
plot(sol)
savefig("../report/image/case3j.png")

plot(sol, idxs=(1,2))
savefig("../report/image/case3_fasj.png")