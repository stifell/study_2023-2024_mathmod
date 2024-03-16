using Plots
using DifferentialEquations

a = 0.01
b = 0.02

N = 4289
I = 82
R = 15
S = N-I-R

tspan = (0, 100)
t = collect(LinRange(0, 200, 1000))
u0 = [S; I; R]

function syst(dy, y, p, t)
    dy[1] = 0
    dy[2] = b*y[2]
    dy[3] = -b*y[2]
end

prob = ODEProblem(syst, u0, tspan)
sol = solve(prob, saveat=t)

plot(sol)

savefig("../report/image/01.png")

function syst(dy, y, p, t)
    dy[1] = -a*y[1]
    dy[2] = a*y[1] - b*y[2]
    dy[3] = b*y[2]
end

prob = ODEProblem(syst, u0, tspan)
sol = solve(prob, saveat=t)

plot(sol)

savefig("../report/image/02.png")