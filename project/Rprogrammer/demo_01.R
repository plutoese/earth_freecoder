library(dplyr)

nrow(starwars)
ncol(starwars)
dim(starwars)

starwars |> 
  filter(skin_color == "light", eye_color == "brown")

starwars |> 
  arrange(height, mass)

starwars |> slice(1:10)

starwars |> 
  select(hair_color, skin_color)