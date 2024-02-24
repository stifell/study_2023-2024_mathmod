---
## Front matter
title: "Математическое моделирование"
subtitle: "Лабораторная работа №3"
author: "Матюшкин Денис Владимирович (НПИбд-02-21)"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Рассмотрение простейшей модели боевых действий – модели Ланчестера.

# Задание
**Вариант 50**

Между страной Х и страной У идет война. Численность состава войск
исчисляется от начала войны, и являются временными функциями $x(t)$ и $y(t)$. В начальный момент времени страна Х имеет армию численностью *61 100* человек, а в распоряжении страны У армия численностью в *45 400* человек. Для упрощения модели считаем, что коэффициенты *a,b,c,h* постоянны. Также считаем $P(t)$ и $Q(t)$ непрервыные функции.

Постройте графики изменения численности войск армии Х и армии У для следующих случаев:

1. Модель боевых действий между регулярными войсками:

$$\frac{dx}{dt} = -0,41x(t) - 0,89y(t) + sin(t + 7) + 1$$
$$\frac{dy}{dt} = -0,52x(t) - 0,61y(t) + cos(t + 6) + 1$$

2. Модель ведение боевых действий с участием регулярных войск и партизанских отрядов

$$\frac{dx}{dt} = -0,37x(t) - 0,675y(t) + |2sin(t)|$$
$$\frac{dy}{dt} = -0,432x(t)y(t) - 0,42y(t) + cos(t) + 2$$

# Теоретическое введение
Julia - это высокопроизводительный язык программирования, который сочетает в себе скорость компилируемых языков с удобством использования скриптовых языков. Он предназначен для научных вычислений, анализа данных и создания высокопроизводительных приложений. Julia поддерживает многопоточность, имеет обширную экосистему библиотек и является проектом с открытым исходным кодом [@julia-doc:documentation].

OpenModelica - это свободная и открытая среда для моделирования и анализа динамических систем. Она предоставляет инструменты для создания и симуляции моделей в различных областях, таких как инженерия, наука, экономика [@openmodelica-doc:documentation].

Дифференциальные уравнения (ДУ) - это уравнения, которые содержат производные неизвестной функции. Они используются для описания изменения величин в зависимости от времени или других независимых переменных [@egorov:differential].

Законы Ланчестера представляют собой математические формулы для расчета относительных сил пары сражающихся сторон – подразделений вооруженных сил. Наиболее известными и получившими широкое распространение являются так
называемые Ланчестеровские модели, использующие аппарат дифференциальных уравнений для описания динамики численности сил участников военных конфликтов как функции от времени [@sazanova:model].

# Выполнение лабораторной работы

## Математическая модель
Рассмотрим три случая ведения боевых действий:

1. Боевые действия между регулярными войсками.
2. Боевые действия с участием регулярных войск и партизанских отрядов.
3. Боевые действия между партизанскими отрядами.

### Боевые действия между регулярными войсками

В первом случае численность регулярных войск определяется тремя факторами:

- скорость уменьшения численности войск из-за причин, не связанных с боевыми действиями (болезни, травмы, дезертирство);
- скорость потерь, обусловленных боевыми действиями противоборствующих сторон (что связанно с качеством стратегии, уровнем вооружения, профессионализмом солдат и т.п.);
- скорость поступления подкрепления (задаётся некоторой функцией от времени).

В этом случае модель боевых действий между регулярными войсками описывается следующим образом: 

$$\frac{dx}{dt} = -a(t)x(t) - b(t)y(t) + P(t)$$
$$\frac{dy}{dt} = -c(t)x(t) - h(t)y(t) + Q(t)$$

Потери, не связанные с боевыми действиями, описывают члены $-a(t)x(t)$ и $-h(t)y(t)$, члены $-b(t)y(t)$ и $-c(t)x(t)$ отражают потери на поле боя. Коэффициенты $b(t)$ и $c(t)$ указывают на эффективность боевых действий со
стороны $у$ и $х$ соответственно, $a(t),h(t)$ - величины, характеризующие степень влияния различных факторов на потери. Функции $P(t),Q(t)$ учитывают возможность подхода подкрепления к войскам Х и У в течение одного дня.

Эта модель соответствует первому заданию.

### Боевые действия с участием регулярных войск и партизанских отрядов

Во втором случае в борьбу добавляются партизанские отряды. Нерегулярные войска в отличии от постоянной армии менее уязвимы, так как действуют скрытно, в этом случае сопернику приходится действовать неизбирательно, по площадям, занимаемым партизанами. Поэтому считается, что тем потерь партизан, проводящих свои операции в разных местах на некоторой известной территории, пропорционален не только численности армейских соединений, но и численности самих партизан. В результате модель принимает вид:

$$\frac{dx}{dt} = -a(t)x(t) - b(t)y(t) + P(t)$$
$$\frac{dy}{dt} = -c(t)x(t)y(t) - h(t)y(t) + Q(t)$$

Эта модель соответствует второму заданию.

### Боевые действия между партизанскими отрядами

Модель ведение боевых действий между партизанскими отрядами с учетом
предположений, сделанном в предыдущем случаем, имеет вид:

$$\frac{dx}{dt} = -a(t)x(t) - b(t)x(t)y(t) + P(t)$$
$$\frac{dy}{dt} = -h(t)y(t) - c(t)x(t)y(t) + Q(t)$$

## Решение с помощью двух языков

### Решение на Julia

**Программа для первого случая:**

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

X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi = 300, legend= true, bg =:white)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 1", legend=:outerbottom)
plot!(plot_solution, time, X_population, label="Численность армии X", color =:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color =:green)

savefig(plot_solution, "case1.png")
```

График первого случая на Julia (рис. @fig:001).

![Боевые действия между регулярными войсками](image/case1(jl).png){#fig:001 width=100%}

**Программа для второго случая:**

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

X_population = [u[1] for u in solution.u]
Y_population = [u[2] for u in solution.u]
time = [t for t in solution.t]

plot_solution = plot(dpi=1200, legend=true, bg=:white)
plot!(plot_solution, time, X_population, label="Численность армии X", color=:red)
plot!(plot_solution, time, Y_population, label="Численность армии Y", color=:green)
plot!(plot_solution, xlabel="Время", ylabel="Численность", title="Модель боевых действий - случай 2", legend=:outerbottom)

savefig(plot_solution, "case2.png")
```

График второго случая на Julia (рис. @fig:002).

![Боевые действия с участием регулярных войск и партизанских отрядов](image/case2(jl).png){#fig:002 width=100%}

### Решение на OpenModelica

**Программа для первого случая:**

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

График первого случая на OpenModelica (рис. @fig:003).

![Боевые действия между регулярными войсками](image/case1(mo).png){#fig:003 width=100%}

**Программа для второго случая:**

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

График второго случая на OpenModelica (рис. @fig:004).

![Боевые действия с участием регулярных войск и партизанских отрядов](image/case2(mo).png){#fig:004 width=100%}

# Выводы

В ходе этой лабораторной работы мы построили математическую модель простейшей модели боевых действий – модели Ланчестера.

# Список литературы{.unnumbered}

::: {#refs}
:::
