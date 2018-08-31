# ----------------------------- #
# Author: Lukas Richter
# Date: 2018-08-30
# ----------------------------- #
# the global file of legi-sbt

library(tidyverse)
library(tools)
library(openxlsx)

profiles <- read_delim("data/profiles.txt", 
                       "\t", escape_double = FALSE, col_names = FALSE, 
                       trim_ws = TRUE)

sbt.name <- "SBT"
allelic.profile <- c("flaA", "pilE", "asd", "mip", "mompS", "proA", "neuA")

colnames(profiles) <- c(sbt.name, allelic.profile)

profiles <- profiles %>% 
  dplyr::mutate_at(allelic.profile, funs(as.character))

# init some stuff


