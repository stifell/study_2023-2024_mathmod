---
## Front matter
title: "Математическое моделирование"
subtitle: "Лабораторная работа №1"
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

Подготовить рабочее пространство для дальнейших лабораторных работ.

# Ход работы

1. Установить Git.
2. Выполнить локальные настройки для Git.
3. Создать резпозиторий на Github для рабочего пространства (рис. @fig:001).

![Создание репозитория](image/1.png){#fig:001 width=100%}

4. Клонирование репозитория (рис. @fig:002).

![Клонирование репозитория](image/2.png){#fig:002 width=100%}

5. Установить pandoc и Miktex (рекомендуется Texlive, но если Miktex, придется устанавливать шрифты вручную). Также установить pandoc-crossref.

6. В папке для доклада и презентации прописать команду *make* для запуска Makefile (рис. @fig:003 и @fig:004).

![Запуск Makefile для report](image/3.png){#fig:003 width=100%}

![Запуск Makefile для presentation](image/4.png){#fig:004 width=100%}

# Выводы

В ходе этой лабораторной работы мы подготовили рабочее пространство для дальнейших лабораторных работ.