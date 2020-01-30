# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Download the whole images
downloaddataCI <- function(URL) {
  # Input: The link to the dropbbox data
  
  # Download the data
  download.file(url=sprintf(URL, 1), destfile = 'data/CI/CompleteImages.zip', method = 'auto')
  
  # Unzip the data
  unzip(zipfile='data/CI/CompleteImages.zip', exdir = 'data/CI')
  
  # Remove the zipfile
  file.remove('data/CI/CompleteImages.zip')
  
}




