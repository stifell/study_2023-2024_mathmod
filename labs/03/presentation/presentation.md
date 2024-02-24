---
## Front matter
lang: ru-RU
title: Математическое моделирование
subtitle: Лабораторная работа №3
author:
  - Матюшкин Д. В.
institute:
  - Российский университет дружбы народов, Москва, Россия
date: 24 февраля 2024

## i18n babel
babel-lang: russian
babel-otherlangs: english

## Formatting pdf
toc: false
toc-title: Содержание
slide_level: 2
aspectratio: 169
section-titles: true
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
 - '\makeatletter'
 - '\beamer@ignorenonframefalse'
 - '\makeatother'

## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
---

# Информация

## Докладчик

:::::::::::::: {.columns align=center}
::: {.column width="70%"}

  * Матюшкин Денис Владимирович
  * студент 3-го курса
  * группа НПИбд-02-21
  * Российский университет дружбы народов
  * [1032212279@pfur.ru](mailto:1032212279@pfur.ru)
  * <https://stifell.github.io/ru/>

:::
::: {.column width="30%"}

![](./image/mat.jpg)

:::
::::::::::::::

# Цель работы

- Рассмотрение простейшей модели боевых действий – модели Ланчестера.

# Задание

## Вариант 50

Между страной Х и страной У идет война. Численность состава войск
исчисляется от начала войны, и являются временными функциями $x(t)$ и $y(t)$. В начальный момент времени страна Х имеет армию численностью *61 100* человек, а в распоряжении страны У армия численностью в *45 400* человек. Для упрощения модели считаем, что коэффициенты *a,b,c,h* постоянны. Также считаем $P(t)$ и $Q(t)$ непрервыные функции.

Постройте графики изменения численности войск армии Х и армии У для следующих случаев:

1. Модель боевых действий между регулярными войсками:

$$\frac{dx}{dt} = -0,41x(t) - 0,89y(t) + sin(t + 7) + 1$$
$$\frac{dy}{dt} = -0,52x(t) - 0,61y(t) + cos(t + 6) + 1$$

## Продолжение

2. Модель ведение боевых действий с участием регулярных войск и партизанских отрядов

$$\frac{dx}{dt} = -0,37x(t) - 0,675y(t) + |2sin(t)|$$
$$\frac{dy}{dt} = -0,432x(t)y(t) - 0,42y(t) + cos(t) + 2$$

# Выполнение лабораторной работы

## 1. Математическая модель

Рассмотрим три случая ведения боевых действий:

1. Боевые действия между регулярными войсками.
2. Боевые действия с участием регулярных войск и партизанских отрядов.
3. Боевые действия между партизанскими отрядами.

## Боевые действия между регулярными войсками

В этом случае модель боевых действий между регулярными войсками описывается следующим образом: 

$$\frac{dx}{dt} = -a(t)x(t) - b(t)y(t) + P(t)$$
$$\frac{dy}{dt} = -c(t)x(t) - h(t)y(t) + Q(t)$$

Эта модель соответствует первому заданию.

## Боевые действия с участием регулярных войск и партизанских отрядов

Во втором случае в борьбу добавляются партизанские отряды. Нерегулярные войска в отличии от постоянной армии менее уязвимы, так как действуют скрытно, в этом случае сопернику приходится действовать неизбирательно, по площадям, занимаемым партизанами. Поэтому считается, что тем потерь партизан, проводящих свои операции в разных местах на некоторой известной территории, пропорционален не только численности армейских соединений, но и численности самих партизан. В результате модель принимает вид:

$$\frac{dx}{dt} = -a(t)x(t) - b(t)y(t) + P(t)$$
$$\frac{dy}{dt} = -c(t)x(t)y(t) - h(t)y(t) + Q(t)$$

Эта модель соответствует второму заданию.

# 2. Решение с помощью двух языков

## Код для первого случая (Julia)

```
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
```

## Продолжение

```
X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi = 300, legend= true, bg =:white)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 1", legend=:outerbottom)
plot!(plot_solution, time, X_population, label="Численность армии X", color =:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color =:green)

savefig(plot_solution, "case1.png")
```

## Код для второго случая (Julia)

```
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
```

## Продолжение

```
X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi=1200, legend=true, bg=:white)
plot!(plot_solution, time, X_population, label="Численность армии X", color=:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color=:green)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 2", legend=:outerbottom)

savefig(plot_solution, "case2.png")
```

## Код для первого случая (OpenModelica)

```
model lab3_1
  Real x;
  Real y;
  Real a = 0.41;
  Real b = 0.89;
  Real c = 0.52;
  Real d = 0.61;
  Real t = time;
initial equation
  x = 61100;
  y = 45400;
equation
  der(x) = -a*x - b*y + sin(t + 7) + 1;
  der(y) = -c*x - d*y + cos(t + 6) + 1;
end lab3_1;
```

## Код для второго случая (OpenModelica)

```
model lab3_2
  Real x;
  Real y;
  Real a = 0.37;
  Real b = 0.675;
  Real c = 0.432;
  Real d = 0.42;
  Real t = time;
initial equation
  x = 61100;
  y = 45400;
equation
  der(x) = -a*x - b*y + 2*abs(sin(t));
  der(y) = -c*x*y - d*y + cos(t) + 2;
end lab3_2;
```

## Результаты (Julia)

Результаты сохраняются в виде графика (рис. [-@fig:001] и [-@fig:002]).

![Боевые действия между регулярными войсками](../report/image/case1(jl).png){#fig:001 width=50%}

## 

![Боевые действия с участием регулярных войск и партизанских отрядов](../report/image/case2(jl).png){#fig:002 width=100%}

## Результаты (OpenModelica)

Сделали скрин для случая с OMEdit (рис. [-@fig:003] и [-@fig:004])

![Боевые действия между регулярными войсками](../report/image/case1(mo).png){#fig:003 width=70%}

##

![Боевые действия с участием регулярных войск и партизанских отрядов](../report/image/case2(mo).png){#fig:004 width=100%}

# Заключение

В ходе этой лабораторной работы мы построили математическую модель простейшей модели боевых действий – модели Ланчестера.

## {.standout}

Спасибо за внимание!