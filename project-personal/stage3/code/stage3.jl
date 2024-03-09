using Plots

const M = 12
const N = 120
const w = 2.5
const h = 1.0
const deltaT = 1.0

const cp = 3.8
const L = 4.42

const Tm = 5
const Tinf = 6

const l = 4.31323
const delta = 139.547327
const hi = 100

const rows, cols = 131, 131
Dend = zeros(Float64, rows, cols)
Temp = zeros(Float64, rows, cols)
Dend[Int((rows - 1) / 2), Int((cols - 1) / 2)] = 1
Temp[Int((rows - 1) / 2), Int((cols - 1) / 2)] = cp * (Tm - Tinf) / L
Grad = zeros(Float64, rows, cols)

global x = 0
global y = 0  
const dendrite_size = 10

function part_A()
    global y
    if y < N
        global x
        if x < M
            for i in 1:rows
                for j in 1:cols
                    Tij_sum = 0
                    Tij_sum_w = 0

                    if i > 1
                        Tij_sum += Temp[i - 1, j]
                        if j > 1
                            Tij_sum_w += Temp[i - 1, j - 1]
                        end
                    end

                    if j > 1
                        Tij_sum += Temp[i, j - 1]
                        if i < rows
                            Tij_sum_w += Temp[i + 1, j - 1]
                        end
                    end

                    if i < rows
                        Tij_sum += Temp[i + 1, j]
                        if j > 1
                            Tij_sum_w += Temp[i + 1, j - 1]
                        end
                    end

                    if j < cols
                        Tij_sum += Temp[i, j + 1]
                        if i < rows
                            Tij_sum += Temp[i + 1, j + 1]
                        end
                    end

                    Tij = (Tij_sum + w * Tij_sum_w) / (4 + 4 * w)
                    Grad[i, j] = (Tij - Temp[i, j]) / ((4 + 4 * w) * (1 + 2 * w) * (h * h))
                    if Dend[i, j] == 0 && rand() < 0.05 * dendrite_size
                        Dend[i, j] = 1
                        Temp[i, j] = Temp[Int((rows - 1) / 2), Int((cols - 1) / 2)]
                    end
                end
            end
        end
    end
end


function part_B()
    global x
    for i in Int((rows - 1) / 2):-1:1
        for j in Int((cols - 1) / 2):-1:1
            if Dend[i, j] == 0
                Temp[i, j] = Temp[i, j] + hi * deltaT * Grad[i, j] / M 
            end
        end
    end

    for i in Int((rows - 1) / 2):rows
        for j in Int((cols - 1) / 2):cols
            if Dend[i, j] == 0
                Temp[i, j] = Temp[i, j] + hi * deltaT * Grad[i, j] / M
            end
        end
    end

    global x += 1
    part_A()
end

function part_C()
    global y
    for i in 1:rows
        for j in 1:cols
            sum_not_diagonal = 0
            sum_diagonal = 0

            if i > 1
                sum_not_diagonal += Dend[i - 1, j]
                if j > 1
                    sum_diagonal += Dend[i - 1, j - 1]
                end
            end

            if j > 1
                sum_not_diagonal += Dend[i, j - 1]
                if i < rows
                    sum_diagonal += Dend[i + 1, j - 1]
                end
            end

            if i < rows
                sum_not_diagonal += Dend[i + 1, j]
                if j > 1
                    sum_diagonal += Dend[i + 1, j - 1]
                end
            end

            if j < cols
                sum_not_diagonal += Dend[i, j + 1]
                if i < rows
                    sum_diagonal += Dend[i + 1, j + 1]
                end
            end

            k = sum_diagonal + sum_not_diagonal
            if k >= 1
                S = sum_not_diagonal + w * sum_diagonal - (2.5 + 2.5 * w)
                T = Temp[Int((rows - 1) / 2), Int((cols - 1) / 2)] * (1 + nu[i, j] * delta) + l * S

                if Temp[i, j] < T
                    Dend[i, j] = 1
                    Temp[i, j] = Temp[Int((rows - 1) / 2), Int((cols - 1) / 2)]
                end
            end
        end
    end
end

part_A()

heatmap(Dend, color=:grays, c=:grays, xlims=(1, cols), ylims=(1, rows), xlabel="Column", ylabel="Row", title="Dendrite Growth", size=(1920, 1080))

savefig("dendrite_growth.png")
