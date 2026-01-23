# Setup MassWateR --------------------------------------------------------

# install MassWateR (if not already installed)
install.packages("MassWateR")

# load MassWateR
library(MassWateR)

# Setup Fata -------------------------------------------------------------

setwd("C:/Users/mbeck/Desktop/MassWateR Example")

# import results, DQOs, site, WQX, and censored metadata
resdat <- readMWRresults("Results.xlsx")
accdat <- readMWRacc("DQOAccuracy.xlsx")
frecomdat <- readMWRfrecom("DQOFrequencyCompleteness.xlsx")
sitdat <- readMWRsites("Sites.xlsx")
wqxdat <- readMWRwqx("WQX.xlsx")
censdat <- readMWRcens("Censored.xlsx")

# combine all
fsetls <- list(res = resdat,
                acc = accdat,
                frecom = frecomdat,
                sit = sitdat,
                wqx = wqxdat,
                cens = censdat)

# Review Files -----------------------------------------------------------

str(resdat)
head(resdat)
View(resdat)
View(accdat)
View(frecomdat)
View(sitdat)
View(wqxdat)
View(censdat)

# Outlier Analysis -------------------------------------------------------

anlzMWRoutlier(fset = fsetls, param = "DO", type = "box", group = "month")
anlzMWRoutlier(fset = fsetls, param = "DO", group = "month", outliers = T)
anlzMWRoutlierall(fset = fsetls, group = "month", format = "word", output_dir = "Output")

# QC Report --------------------------------------------------------------

# individual tables
tabMWRfre(fset = fsetls, type = "percent")
tabMWRfre(fset = fsetls, type = "summary")
tabMWRacc(fset = fsetls, type = "percent")
tabMWRacc(fset = fsetls, type = "summary")
tabMWRcom(fset = fsetls)

# complete report
qcMWRreview(fset = fsetls, output_dir = "Output")
qcMWRreview(fset = fsetls, output_dir = "Output", savesheet = T)

# WQX upload -------------------------------------------------------------

tabMWRwqx(fset = fsetls, output_dir = "Output")

# Analysis ---------------------------------------------------------------

# by season
anlzMWRseason(fset = fsetls, param = "DO", thresh = "fresh", group = "month", type = "box")
anlzMWRseason(fset = fsetls, param = "DO", thresh = "fresh", group = "month", type = "jitterbar")

# by date
anlzMWRdate(fset = fsetls, param = "DO", thresh = "fresh", group = "site", site = c("ABT-026", "ABT-077"))

# by site
anlzMWRsite(fset = fsetls, param = "DO", thresh = "fresh", type = "box")
anlzMWRsite(fset = fsetls, param = "DO", thresh = "fresh", type = "jitterbar")

# map
anlzMWRmap(fset = fsetls, param = "DO", addwater = "high")
anlzMWRmap(fset = fsetls, param = "DO", addwater = "high", maptype = "CartoDB.Positron", palcol = "Reds")
