
#---------------------------------------------------------------#
# Chargement d'une table de données depuis mon bucket personnel #
#---------------------------------------------------------------#

# test d'une modification !!

# Cf https://www.book.utilitr.org/sspcloud.html  (droits daccès au s3)
source("credentials.R")


# install.packages("aws.s3", repos = "https://www.book.utilitr.org/sspcloud.html")
library("aws.s3")

bucketlist(region="")

#ex : données au format RDS
RP16_Ind_LR <- 
  aws.s3::s3read_using(
    FUN = readRDS,
    # Mettre les options de FUN ici
    object = "/Donnees_RP/RP16_Ind_LR.rds",
    bucket = "m2909b",
    opts = list("region" = "")
  )


library(tidyverse)
RP16_Ind_LR %>% colnames()


# Sauvegarder un fichier dans son bucket personnel
library(doremifasolData)
RP_Boulogne <- RP16_Ind_LR %>%
  ungroup() %>% 
  filter(CODGEO == "62160")

aws.s3::s3write_using(
  RP_Boulogne,
  FUN = saveRDS,
  # Les options de fread sont ici
  object = "Donnees_RP/RP_Boulogne.RDS",
  bucket = "m2909b",
  opts = list("region" = "")
)













