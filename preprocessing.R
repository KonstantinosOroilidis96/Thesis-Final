# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Function to preprocess the clips
preprocessing <- function(listfiles) {
  # Input: The list of Ortho files
  
  OrthoRaster <<- raster(listfiles[2])
  Ortho181019 <<- stack(listfiles[2]) #Make raster of date 1
  Ortho201119 <<- stack(listfiles[1]) #Make raster of date 2
  
  # Visualize the output
  plot(Ortho181019)
  plot(Ortho201119)
  
  # Import the polygon features
  TrainingPolygonsOct <<- readOGR(dsn = "data", layer = "MS_18_10_Polys")
  TrainingPolygonsNov <<- readOGR(dsn = "data", layer = "MS_20_11_Polys")
  
  # Visualize the output
  plot(TrainingPolygonsOct)
  crs(TrainingPolygonsOct)
  
  # Equalize the coordinate systems
  CRSPolys <<- projectExtent(OrthoRaster, crs = crs(TrainingPolygonsOct))
  Ortho181019prj <<- projectRaster(Ortho181019, CRSPolys)
  Ortho201119prj <<- projectRaster(Ortho201119, CRSPolys)
  
}