resultsFolder <- here("Results", dbName)
if (!file.exists(resultsFolder)){
  dir.create(resultsFolder, recursive = TRUE)}
results <- list()
loggerName <- gsub(":| |-", "_", paste0("log_01_001_", Sys.time(), ".txt"))
logger <- create.logger()
logfile(logger) <- here(resultsFolder, loggerName)
level(logger) <- "INFO"
info(logger, "LOG CREATED")

snapshot <- OmopSketch::summariseOmopSnapshot(cdm)

### Create Cohort

cdm$cardiac_arrest <- CohortConstructor::conceptCohort(
  cdm = cdm,
  conceptSet = list(cardiac_arrest = 321042),
  name = "cardiac_arrest"
)


### Characterisation

characteristics <- CohortCharacteristics::summariseCharacteristics(cdm$cardiac_arrest,
                                                                   ageGroup = list(c(0, 49), c(50, 150)))

lsc <- CohortCharacteristics::summariseLargeScaleCharacteristics(cohort = cdm$cardiac_arrest,
                                                                 window = list(c(-30,-1),c(0,0),c(1,30)),
                                                                 eventInWindow = c("condition_occurrence"))

### Incidence

cdm <- IncidencePrevalence::generateDenominatorCohortSet(
  cdm = cdm,
  name = "denominator"
)

incidence <- IncidencePrevalence::estimateIncidence(
  cdm = cdm,
  denominatorTable = "denominator",
  outcomeTable = "cardiac_arrest"
)

### Export Results
p1 <- CohortCharacteristics::plotCharacteristics(characteristics)
p2 <- CohortCharacteristics::plotLargeScaleCharacteristics(lsc)
p3 <- IncidencePrevalence::plotIncidence(incidence)


