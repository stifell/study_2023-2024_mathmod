---
## Front matter
title: "Математическое моделирование"
subtitle: "Лабораторная работа №5"
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
lot: false # List of tables
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

Построение простейшей модели взаимодействия двух видов типа «хищник — жертва» - модель Лотки-Вольтерры.

# Задание
**Вариант 50**

Для модели «хищник-жертва»:

$$
 \begin{cases}
	\frac{dx}{dt} = -0.71x(t) + 0.046x(t)y(t)
	\\   
	\frac{dy}{dt} = 0.64y(t) - 0.017x(t)y(t)
 \end{cases}
$$

Постройте график зависимости численности хищников от численности жертв, а также графики изменения численности хищников и численности жертв при следующих начальных условиях: $x_0=4, y_0=12$. Найдите стационарное состояние системы.


# Теоретическое введение
Julia - это высокопроизводительный язык программирования, который сочетает в себе скорость компилируемых языков с удобством использования скриптовых языков. Он предназначен для научных вычислений, анализа данных и создания высокопроизводительных приложений. Julia поддерживает многопоточность, имеет обширную экосистему библиотек и является проектом с открытым исходным кодом [@julia-doc:documentation].

OpenModelica - это свободная и открытая среда для моделирования и анализа динамических систем. Она предоставляет инструменты для создания и симуляции моделей в различных областях, таких как инженерия, наука, экономика [@openmodelica-doc:documentation].

Простейшая модель взаимодействия двух видов типа «хищник — жертва» -
модель Лотки-Вольтерры [@lotka:equations]. Данная двувидовая модель основывается на следующих предположениях:

1. Численность популяции жертв и хищников зависят только от времени (модель не учитывает пространственное распределение популяции на занимаемой территории)
2. В отсутствии взаимодействия численность видов изменяется по модели Мальтуса, при этом число жертв увеличивается, а число хищников падает
3. Естественная смертность жертвы и естественная рождаемость хищника считаются несущественными
4. Эффект насыщения численности обеих популяций не учитывается
5. Скорость роста численности жертв уменьшается пропорционально численности хищников:

$$
 \begin{cases}
	\frac{dx}{dt} = ax(t) - bx(t)y(t)
	\\   
	\frac{dy}{dt} = -cy(t) + dx(t)y(t)
 \end{cases}
$$

В этой модели x – число жертв, y - число хищников. Коэффициент a описывает скорость естественного прироста числа жертв в отсутствие хищников, с - естественное вымирание хищников, лишенных пищи в виде жертв. Вероятность взаимодействия жертвы и хищника считается пропорциональной как количеству жертв, так и числу самих хищников (xy). Каждый акт взаимодействия уменьшает популяцию жертв, но способствует увеличению популяции хищников (члены -bxy и dxy в правой части уравнения).

Математический анализ этой (жесткой) модели показывает, что имеется стационарное состояние, всякое же другое начальное состояние приводит к периодическому колебанию численности как жертв, так и хищников, так что по прошествии некоторого времени система возвращается в состояние.

Стационарное состояние системы (положение равновесия, не зависящее
от времени решение) будет в точке: $x_0=\frac{c}{d}, y_0=\frac{a}{b}$. Если начальные значения задать в стационарном состоянии $x(0)=x_0, y(0)=y_0$, то в любой момент времени численность популяций изменяться не будет.

# Выполнение лабораторной работы

## Решение на Julia

```
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

```

## Решение на OpenModelica

```
model lab5
Real x(start=4);
Real y(start=12);

parameter Real a = 0.71;
parameter Real b = 0.046;
parameter Real c = 0.64;
parameter Real d = 0.017;

equation
  der(x) = -a*x + b*x*y;
  der(y) = c*y - d*x*y;
end lab5;
```

## Результаты работы

Результаты на Julia (рис. @fig:001 и @fig:002).

![График зависимости численности жертв и хищников от времени (Julia)](image/01_jl.png){#fig:001 width=100%}

![График зависимости численности хищников от численности жертв (Julia)](image/02_jl.png){#fig:002 width=100%}

Результаты на OpenModelica (рис. @fig:003 и @fig:004).

![График зависимости численности жертв и хищников от времени (OpenModelica)](image/01_om.png){#fig:003 width=100%}

![График зависимости численности хищников от численности жертв (OpenModelica)](image/02_om.png){#fig:004 width=100%}

Стационарное состояние системы будет в точке: $x_0=\frac{0.64}{0.017} \approx 37.65, y_0=\frac{0.71}{0.046} \approx 15.43$

# Выводы

В ходе выполнения лабораторной работы мы построили простейшую модель взаимодействия двух видов типа «хищник — жертва» - модель Лотки-Вольтерры.

# Список литературы{.unnumbered}

::: {#refs}
:::
