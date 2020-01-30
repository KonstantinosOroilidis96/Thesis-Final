# Geoscripting 2020 
# Project Week 4
# Weed detection with random forest pixel based classification
# Old MGI Version
# Jos Westdijk & Konstatinos Oroilidis
# 31 January 2020

# Function to plot the November data
plotNov<- function(toplot) {
  # The predicted land use for November
  
  # Set the filename and colors
  cols <- c("green", "brown", "light blue", "yellow", "orange")
  png(filename='./output/November_Prediction', width=600, height=600)
  
  # Plot the data
  plot(toplot, col=cols, legend=FALSE, axes=F)
  title("J.R Westdijk, K.Oroilidis, 16 January 2020\nPredicted Land Cover on 20 November 2019", line = -1)
  
  # Add a legend
  legend("bottomright", legend=c("grass", "soil", "weed1", "weed2", "weed3"), fill=cols, bg="white")
  
  # Add CRS
  mtext(side = 3, line = -5, paste('crs: ', st_crs(TrainingPolygonsNov)[1], '   \nsrc: MavicPro  '), adj = 1, cex = 1.25, col = 'grey20')
  
  dev.off()
}