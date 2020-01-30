# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020



###############################################################
#################### SETTING UP ENVIRONMENT ###################
###############################################################

# Source Functions
source("R/downloaddata.R")
source("R/preprocessing.R")
source("R/dataframe.R")
source("R/plotNov.R")
source("R/plotOct.R")
source("R/barplotOct.R")
source("R/barplotNov.R")
source("R/downloaddataCI.R")
source("R/preprocessingCI.R")

# Install (if necessary) and import the packages
if (!require("raster")) install.packages("raster")
if (!require("rgdal")) install.packages("rgdal")
if (!require("randomForest")) install.packages("randomForest")
if (!require("sf")) install.packages("sf")
library(raster)
library(rgdal)
library(randomForest)
library(sf)

# Create necessary directories
if (!dir.exists('data')){
  dir.create('data', showWarnings = FALSE)}

if (!dir.exists('data/CI')){
  dir.create('data/CI', showWarnings = FALSE)}

if (!dir.exists('output')) {
  dir.create('output', showWarnings = FALSE)
}



###############################################################
######################## PREPROCESSING ########################
###############################################################

# Download the Ortho data
downloaddata("https://www.dropbox.com/s/iiwmk32nnaticzm/Dataset.zip?dl=1")

# List the Ortho files 
Ortho <- list.files(path='data', pattern = glob2rx('*.tif'), full.names=TRUE)

# Preprocess the data
preprocessing(Ortho)

# Change the polygon data to integers
TrainingPolygonsOct@data$Class <- as.numeric(TrainingPolygonsOct@data$Code) #October
TrainingPolygonsNov@data$Class <- as.numeric(TrainingPolygonsNov@data$Code) #November

# Assign the 'Class' Values to raster cells 
classesOct <- rasterize(TrainingPolygonsOct, CRSPolys, field='Class')
classesNov <- rasterize(TrainingPolygonsNov, CRSPolys, field='Class')

# Create the dataframes
dataframe(Ortho181019prj, classesOct) #October
TPValueTableOct <- TPValueTable #October
dataframe(Ortho201119prj, classesNov) #November
TPValueTableNov <- TPValueTable #November

# Convert the code colums into a factor
TPValueTableOct$Code <- factor(TPValueTableOct$Code, levels = c(1:5)) #October
TPValueTableNov$Code <- factor(TPValueTableNov$Code, levels = c(1:5)) #November



###############################################################
###################### PREPROCESSING CI #######################
###############################################################
###### ONLY RUN THIS IF YOU HAVE ENOUGH PROCESSING POWER ######
###############################################################

# Download the CI Files
downloaddataCI("https://www.dropbox.com/s/4m8fb6tmxf8tzht/CI.zip?dl=1")

# List the CI files
CI <- list.files(path='data/CI', pattern = glob2rx('*.tif'), full.names=TRUE)

# Preprocess the CI data
preprocessingCI(CI)

# Equalize names
names(CI181019prj) = c("OctClip.1", "OctClip.2", "OctClip.3", "OctClip.4")
names(CI201119prj) = c("NovClip.1", "NovClip.2", "NovClip.3", "NovClip.4")


###############################################################
###################### RUNNING THE MODEL ######################
###############################################################

# Run the randomForest Model
modelRFOct <- randomForest(x=TPValueTableOct[,c(1:4)], y=TPValueTableOct$Code, importance=TRUE) #October
modelRFNov <- randomForest(x=TPValueTableNov[,c(1:4)], y=TPValueTableNov$Code, importance=TRUE) #November

# Make the structure of the matrix more readable
colnames(modelRFOct$confusion) <- c("grass", "soil", "weed1", "weed2", "weed3", "class.error") #October
rownames(modelRFOct$confusion) <- c("grass", "soil", "weed1", "weed2", "weed3") #October
write.csv(modelRFOct$confusion,'./output/confusion_matrix_Oct.csv') #October
colnames(modelRFNov$confusion) <- c("grass", "soil", "weed1", "weed2", "weed3", "class.error") #November
rownames(modelRFNov$confusion) <- c("grass", "soil", "weed1", "weed2", "weed3") #November
write.csv(modelRFNov$confusion,'./output/confusion_matrix_Nov.csv') #November

# Predict the land cover using the RF Model
predictedLandcoverOct <- predict(Ortho181019prj, modelRFOct, na.rm=TRUE, filename='./output/Ortho181019_Prediction.tif', overwrite=TRUE)
predictedLandcoverNov <- predict(Ortho201119prj, modelRFNov, na.rm=TRUE, filename='./output/Ortho201119_Prediction.tif', overwrite=TRUE)

# [Run these instead of the above plotting if there is enough processing power]
predictedLandcoverOctCI <- predict(CI181019prj, modelRFOct, na.rm=TRUE, filename='./output/CI181019_Prediction.tif', overwrite=TRUE)
predictedLandcoverNovCI <- predict(CI201119prj, modelRFNov, na.rm=TRUE, filename='./output/CI201119_Prediction.tif', overwrite=TRUE)

###############################################################
###################### PLOTTING OUTCOMES ######################
###############################################################
# Tiling (for) -> Run function -> Merge it together

# Plot the predicted landcover
plotOct(predictedLandcoverOct) #October
plotNov(predictedLandcoverNov) #November

# Present statistics data
barplotOct(predictedLandcoverOct, classesOct) #October
barplotNov(predictedLandcoverNov, classesNov) #November

# [Run these instead of the above plotting if there is enough processing power]
# Plot the predicted landcover for CI
plotOct(predictedLandcoverOctCI) #October
plotNov(predictedLandcoverNovCI) #November

# Present statistics data for CI
barplotOct(predictedLandcoverOctCI, classesOct) #October
barplotNov(predictedLandcoverNovCI, classesNov) #November
