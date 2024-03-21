using Plots
using DifferentialEquations

a = 0.66
b = 0.00006
N = 2010

tmax = 5
tspan = (0, tmax)
t = collect(LinRange(0, tmax, 500))
n = 29

function syst(dy, y, p, t)
    dy[1] = (a+b*y[1])*(N-y[1])
end

prob = ODEProblem(syst, [n], tspan)
sol = solve(prob, saveat=t)

plot(sol)

savefig("01.png")

a = 0.000066
b = 0.6
N = 2010

tmax= 0.03
tspan = (0, tmax)
t = collect(LinRange(0, tmax, 500))
n = 29

function syst(dy, y, p, t)
    dy[1] = (a+b*y[1])*(N-y[1])
end

prob = ODEProblem(syst, [n], tspan)
sol = solve(prob, saveat=t)

plot(sol)

savefig("02.png")

a = 0.66
b = 0.6
N = 2010

tmax = 0.03
tspan = (0, tmax)
t = collect(LinRange(0, tmax, 500))
n = 29

function syst(dy, y, p, t)
    dy[1] = (a*t+b*t*y[1])*(N-y[1])
end

prob = ODEProblem(syst, [n], tspan)
sol = solve(prob, saveat=t)

plot(sol)

savefig("03.png")