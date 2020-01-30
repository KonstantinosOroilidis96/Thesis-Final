# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020 

# Function to plot the October data in a bar plot
barplotOct<- function(prediction, classes) {
  # Create zonal statistics
  ZonalOct = zonal(prediction, classes, fun = sum) #Calculate the sum of the pixels
  ZonalOct <- as.data.frame(ZonalOct) #Convert the matrix to a dataframe
  per = round((ZonalOct[,2]/sum(ZonalOct))*100, 3) #Calculate the percetage of each landclass
  Percentage = per #Add it to the dataframe
  ZonalOct$Percentage=per #Add it to the dataframe
  
  # Present the results for October
  png(filename = "output/boxplot_October.png")
  barplot(ZonalOct[, 3], col=c("green", "brown", "light blue", "yellow", "orange"), main="Predicted land cover types on 18 October 2019\nJ.R. Westdijk, K. Orolidis,  31 January 2020",
          cex.main=0.8, xlab = "Land cover type", ylab = "Landcover coverage (%)",
          ylim = c(0,100),
          names.arg = c("grass", "soil", "weed1", "weed2", "weed3"))
  par(mfrow = c(1, 1))
  dev.off()
}