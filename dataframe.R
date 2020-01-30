# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Function to create the required dataframes
dataframe <- function(input, classes) {
  # Input: Projected raster as input and for classes use the created classes layer
  
  # Mask the Ortho data and combine the new rasters with the classes layer
  TrainingPolygonsMask <- mask(input, classes)
  names(classes) <- 'Code'
  TrainingPolygonsBrick <- addLayer(TrainingPolygonsMask, classes)
  
  #Extract all values into a matrix
  TPValueTable <- getValues(TrainingPolygonsBrick)
  TPValueTable <- na.omit(TPValueTable)
  
  # Convert the matrix into a the dataframe
  TPValueTable <<- as.data.frame(TPValueTable)
  
}

