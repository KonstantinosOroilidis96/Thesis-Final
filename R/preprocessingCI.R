# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Function to preprocess the whole images
preprocessingCI <- function(listfiles) {
  # Input: The list of Ortho files
  
  OrthoRaster <<- raster(listfiles[2])
  CI181019 <<- stack(listfiles[1]) #Make raster of date 1
  CI201119 <<- stack(listfiles[2]) #Make raster of date 2
  
  # Remove values out of bounds
  CI181019[[1]][CI181019[[1]] > 60000] = NA
  CI181019[[2]][CI181019[[2]] > 60000] = NA
  CI181019[[3]][CI181019[[3]] > 60000] = NA
  CI181019[[4]][CI181019[[4]] > 60000] = NA
  CI201119[[1]][CI201119[[1]] > 60000] = NA
  CI201119[[2]][CI201119[[2]] > 60000] = NA
  CI201119[[3]][CI201119[[3]] > 60000] = NA
  CI201119[[4]][CI201119[[4]] > 60000] = NA
  
  # Equalize the coordinate systems
  CRSPolys <<- projectExtent(OrthoRaster, crs = crs(TrainingPolygonsOct))
  CI181019prj <<- projectRaster(CI181019, CRSPolys)
  CI201119prj <<- projectRaster(CI201119, CRSPolys)
  
}