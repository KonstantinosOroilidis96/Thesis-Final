# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020 

# Function to plot the November data in a bar plot
barplotNov<- function(prediction, classes) {
  # Create zonal statistics
  ZonalNov = zonal(prediction, classes, fun = sum) #Calculate the sum of the pixels
  ZonalNov <- as.data.frame(ZonalNov) #Convert the matrix to a dataframe
  per = round((ZonalNov[,2]/sum(ZonalNov))*100, 3) #Calculate the percetage of each landclass
  Percentage = per #Add it to the dataframe
  ZonalNov$Percentage=per #Add it to the dataframe
  
  # Present the results for November
  png(filename = "output/boxplot_November.png")
  barplot(ZonalNov[, 3], col=c("green", "brown", "light blue", "yellow", "orange"), main="Predicted land cover types on 20 November 2019\nJ.R. Westdijk, K. Orolidis,  31 January 2020",
          cex.main=0.8, xlab = "Land cover type", ylab = "Landcover coverage (%)",
          ylim = c(0,100),
          names.arg = c("grass", "soil", "weed1", "weed2", "weed3"))
  par(mfrow = c(1, 1))
  dev.off()
}