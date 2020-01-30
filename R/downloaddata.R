# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Function to download the required data
downloaddata <- function(URL) {
  # Input: The link to the dropbbox data
  
  # Download the data
  download.file(url=sprintf(URL, 1), destfile = 'data/multispectral.zip', method = 'auto')
  
  # Unzip the data
  unzip(zipfile='data/multispectral.zip', exdir = 'data')
  
  # Remove the zipfile
  file.remove('data/multispectral.zip')
  
}