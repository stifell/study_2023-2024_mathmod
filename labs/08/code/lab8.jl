using Plots
using DifferentialEquations

p_cr=20
N=40
q=1

tau1=20
tau2=15
p1=7
p2=9.5

d = 0.00031

a1 = p_cr/(tau1*tau1*p1*p1*N*q)
a2 = p_cr/(tau2*tau2*p2*p2*N*q)
c1 = (p_cr-p1)/(tau1*p1)
c2 = (p_cr-p2)/(tau2*p2)
b = p_cr/(tau1*tau1*p1*p1*tau2*tau2*p2*p2*N*q)

M1=6.4
M2=4.1

t = collect(LinRange(0, 20, 500))
tspan = (0, 20)

function syst(dy, y, p, t)
    dy[1] = y[1] - (b/c1)*y[1]*y[2] - (a1/c1)*y[1]*y[1]
    dy[2] = (c2/c1)*y[2] - (b/c1)*y[1]*y[2] - (a2/c1)*y[2]*y[2]
end

prob = ODEProblem(syst, [M1, M2], tspan)
sol = solve(prob, saveat=t)

plot(sol)
savefig("../report/image/01.png")

function syst(dy, y, p, t)
    dy[1] = y[1] - (b/c1)*y[1]*y[2] - (a1/c1)*y[1]*y[1]
    dy[2] = (c2/c1)*y[2] - (b/c1+d)*y[1]*y[2] - (a2/c1)*y[2]*y[2]
end

prob = ODEProblem(syst, [M1, M2], tspan)
sol = solve(prob, saveat=t)

plot(sol)
savefig("../report/image/02.png")