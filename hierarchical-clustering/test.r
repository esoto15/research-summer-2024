# Library
library(tidyverse)
 
# Data
head(mtcars)
 
# Clusterisation using 3 variables
mtcars %>% 
  select(mpg, cyl, disp) %>% 
  dist() %>% 
  hclust() %>% 
  as.dendrogram() -> dend
 
# Plot
par(mar=c(7,3,1,1))  # Increase bottom margin to have the complete label
plot(dend)