source("dev/LoadPackage.R")

detach(name = "package:ImmunoCleaner",
       unload = TRUE)
devtools::install()

source("dev/LoadPackage.R")
