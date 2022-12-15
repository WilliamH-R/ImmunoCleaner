source("dev/LoadPackage.R")

detach(name = "package:TCRSequenceFunctions",
       unload = TRUE)
devtools::install()

source("dev/LoadPackage.R")
