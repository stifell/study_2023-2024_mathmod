---
## Front matter
lang: ru-RU
title: Математическое моделирование
subtitle: Лабораторная работа №2
author:
  - Матюшкин Д. В.
institute:
  - Российский университет дружбы народов, Москва, Россия
date: 17 февраля 2024

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

- Построение математической модели для выбора правильной стратегии при решении задач поиска.

# Задание

## Вариант 50

На море в тумане катер береговой охраны преследует лодку браконьеров. Через определенный промежуток времени туман рассеивается, и лодка обнаруживаетсяна расстоянии 16,9 км от катера. Затем лодка снова скрывается в тумане и уходит прямолинейно в неизвестном направлении. Известно, что скорость катера в 4,7 раза больше скорости браконьерской лодки.

1. Запишите уравнение, описывающее движение катера, с начальными
условиями для двух случаев (в зависимости от расположения катера
относительно лодки в начальный момент времени).
2. Постройте траекторию движения катера и лодки для двух случаев.
3. Найдите точку пересечения траектории катера и лодки.

# Выполнение лабораторной работы

## 1. Математическая модель

1. Принимает за $t_0 = 0$, $x_л = 0$ место нахождения лодки браконьеров в
момент обнаружения и $x_к = 16,9$.
2. Введем полярные координаты: $x_л = \theta = 0$, $r$ проходит через точку нахождения катера береговой охраны.
3. Для начала катер береговой охраны должен двигаться некоторое время прямолинейно, пока не окажется на том же расстоянии от полюса, что и лодка браконьеров. После этого катер береговой охраны должен двигаться вокруг полюса удаляясь от него с той же скоростью, что и лодка браконьеров.

##

4. Чтобы найти расстояние $x$, необходимо составить простое уравнение. Пусть через время $t$ катер и лодка окажутся на одном расстоянии $x$ от полюса. За это время лодка пройдет $x$ , а катер $16,9 - x$ (или $16,9 + x$). Неизвестное расстояние $x$ можно найти из следующего уравнения:

- в пером случае
$$\frac{x_1}{v} = \frac{16,9 - x_1}{4,7v}$$ 
- во втором случае 
$$\frac{x_2}{v} = \frac{16,9 + x_2}{4,7v}$$

Отсюда мы найдем два значения $x_1 = \frac{169}{57}$ и $x_2 = \frac{169}{37}$.

##

5. После того, как катер береговой охраны окажется на одном расстоянии от полюса, что и лодка, он должен сменить прямолинейную траекторию и начать двигаться вокруг полюса удаляясь от него со скоростью лодки $v$.
Для этого скорость катера раскладываем на две составляющие: $v_r$ - радиальная скорость и $v_\tau$ - тангенциальная скорость.

- $v_r = \frac{dr}{dt} = v$
- $v_\tau = \frac{rd\theta}{dt}$

$v_\tau = \sqrt{22,09v^2 - v^2}$ (учитывая, что радиальная скорость равна $v$). Тогда получаем $\frac{rd\theta}{dt} = \sqrt{21,09}v$.

##

6. Решение исходной задачи сводится к решению системы из двух дифференциальных уравнений:

$\begin{cases} \frac{dr}{dt} = v \\ \frac{rd\theta}{dt} = \sqrt{21,09}v \end{cases}$
с начальными условиями $\begin{cases} \theta = 0 \\ r = x_1 \end{cases}$ или $\begin{cases} \theta = -\pi \\ r = x_2 \end{cases}$

Исключая из полученной системы производную по t, можно перейти к следующему уравнению:

$$\frac{dt}{d\theta} = \frac{r}{\sqrt{21,09}}$$

## 2. Используем язык Julia для решения этой задачи.

- Код программы для первого случая:
```
using DifferentialEquations
using Plots
const n = 16.9
const v = 4.7
const r = n / (v + 1)
const t1 = (0, 2pi)
function F(u, p, t)
    return u / sqrt(v*v - 1)
end
setup = ODEProblem(F, r, t1)
result = solve(setup, abstol=1e-8, reltol=1e-8)
index = rand(1:size(result.t)[1])
```

## 

```
rAngles = [result.t[index] for i in 1:size(result.t)[1]]
plt = plot(proj=:polar, aspect_ratio=:equal, dpi = 1000, legend=true, bg=:white)
plot!(plt, [rAngles[1], rAngles[2]], [0.0, result.u[size(result.u)[1]]], label="Путь лодки", color=:red, lw=1)
scatter!(plt, rAngles, result.u, label="", mc=:red, ms=0.0005)
plot!(plt, result.t, result.u, xlabel="theta", ylabel="r(t)", label="Путь катера", color=:green, lw=1)
scatter!(plt, result.t, result.u, label="", mc=:green, ms=0.0005)
savefig(plt, "case1.png")
```

##

- Код программы для второго  случая:

```
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
```

##

```
plt = plot(proj=:polar, aspect_ratio=:equal, dpi = 1000, legend=true, bg=:white)
plot!(plt, [rAngles[1], rAngles[2]], [0.0, result.u[size(result.u)[1]]], label="Путь лодки", color=:red, lw=1)
scatter!(plt, rAngles, result.u, label="", mc=:red, ms=0.0005)
plot!(plt, result.t, result.u, xlabel="theta", ylabel="r(t)", label="Путь катера", color=:green, lw=1)
scatter!(plt, result.t, result.u, label="", mc=:green, ms=0.0005)
savefig(plt, "case2.png")
```

## Результаты

Результаты сохраняются в виде картинки с расширешнием png (рис. [-@fig:001] и [-@fig:002]).

![Траекторию движения катера и лодки для первого случая](../case1.png){#fig:001 width=50%}

## 

![Траекторию движения катера и лодки для второго случая](../case2.png){#fig:002 width=70%}

# Заключение

В ходе этой лабораторной работы ознакомились c языками программирования Julia и OpenModelica. Построили математическую модель для выбора правильной стратегии при решении задач поиска.

## {.standout}

Спасибо за внимание!