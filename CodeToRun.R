# Restore renv
renv::restore()

library(CDMConnector)
library(OmopSketch)
library(here)
library(log4r)
library(CohortCharacteristics)
library(CohortConstructor)
library(IncidencePrevalence)
dbName <- "..."

con <- DBI::dbConnect("...")

cdmSchema <- "..."
writeSchema <- "..."

prefix <- "..."


cdm <- CDMConnector::cdmFromCon(con = con,
                                cdmSchema = cdmSchema, 
                                writeSchema = c(schema = writeSchema,
                                                prefix = prefix))

minCellCount = 5


source("RunCode.R")
