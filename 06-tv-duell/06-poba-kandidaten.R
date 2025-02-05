library(tidyverse)
library(haven)

df_poba_1987 <- read_dta(here("data", "Politbarometer", "ZA1899.dta"))
count(df_poba_1987, v35)

weighted_skalo <- function(skalo, df, wt, erhebungsmonat) {
  df |> 
    filter(v3 == erhebungsmonat) |> 
    summarize(weighted.mean({{skalo}} - 6, w = {{wt}}, na.rm = TRUE)) |> 
    pull()
}

# Bundestagswahl am 27.01.1987

# Repräsentativgewicht v206
df_poba_1987 |> 
  group_by(v3) |> 
  summarize(mean(v206))


# KOHL

# ungewichtet
df_poba_1987 |> 
  filter(v3 == 1) |> 
  transmute(v35 = v35 - 6) |> 
  na.omit() |> 
  summarize(mean(v35))

# gewichtet
df_poba_1987 |> 
  filter(v3 == 1) |> 
  transmute(v206, v35 = v35 - 6) |> 
  na.omit() |> 
  count(v35, wt = v206) |> 
  summarize(sum(v35 * n)/ sum(n))

df_poba_1987 |> 
  filter(v3 == 1) |> 
  summarize(weighted.mean(v35 - 6, w = v206, na.rm = TRUE))
weighted_skalo(v35, df_poba_1987, v206, 1)


# RAU
df_poba_1987 |> 
  filter(v3 == 1) |> 
  summarize(weighted.mean(v41 - 6, w = v206, na.rm = TRUE))
weighted_skalo(v41, df_poba_1987, v206, 1)


## 1980 (Wahltermin 05.10.1980)
df_poba_1980 <- read_dta(here("data", "Politbarometer", "ZA1053.dta"))
table(df_poba_1980$v5)
# Schmidt
df_poba_1980 |> 
  filter(v5 == 9) |>
  summarize(round(weighted.mean(v32 - 6, w = v4, na.rm = TRUE), 1))
# Strauß
df_poba_1980 |> 
  filter(v5 == 9) |>
  summarize(round(weighted.mean(v33 - 6, w = v4, na.rm = TRUE), 1))


## 1983
df_poba_1983 <- read_dta(here("data", "Politbarometer", "ZA2209.dta"))
# Wahltermin 06.03.1983 --> Feb
table(df_poba_1983$v3)
# Kohl
round(weighted_skalo(v42, df_poba_1983, v182, 2), 1)
# Vogel
round(weighted_skalo(v45, df_poba_1983, v182, 2), 1)


## 1990
df_poba_1990 <- read_dta(here("data", "Politbarometer", "ZA1920.dta"))
# Wahltermin 02.12.1990
table(df_poba_1990$v3)
# Kohl
round(weighted_skalo(v84, df_poba_1990, v284, 11), 1)
# Lafontaine
round(weighted_skalo(v85, df_poba_1990, v284, 11), 1)




## 1994
df_poba_1994 <- read_dta(here("data", "Politbarometer", "ZA2546.dta"))
table(df_poba_1994$v3)
## --> 09 = Blitzumfrage vor der Wahl laut Codebuch
# Kohl
round(weighted_skalo(v95, df_poba_1994, v310, 9), 1)
# Scharping
round(weighted_skalo(v98, df_poba_1994, v310, 9), 1)


## 1998
df_poba_1998 <- read_dta(here("data", "Politbarometer", "ZA3160.dta"))

# Kohl
round(weighted_skalo(v102, df_poba_1998, v370, 9), 1)
# Schröder
round(weighted_skalo(v109, df_poba_1998, v370, 9), 1)

## 2002
df_poba_2002 <- read_dta(here("data", "Politbarometer", "ZA3851.dta"))

# Schröder
round(weighted_skalo(v89, df_poba_2002, v203, 9), 1)
# Stoiber
round(weighted_skalo(v91, df_poba_2002, v203, 9), 1)
