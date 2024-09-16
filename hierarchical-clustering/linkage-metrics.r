# Install and load necessary packages
# install.packages("cluster")
# install.packages("ggplot2")
# install.packages("ggdendro")
# install.packages("readxl")
# install.packages("openxlsx")

library(cluster)
library(ggplot2)
library(ggdendro)
library(readxl)
library(openxlsx)

# --------------Dataset----------------
data <- read_excel("datasets/demo-encoded.xlsx")

# --------------Hierarchical Clustering----------------
# Try different linkage methods
agnes_ward <- agnes(data, method = "ward")
agnes_single <- agnes(data, method = "single")
agnes_complete <- agnes(data, method = "complete")
agnes_average <- agnes(data, method = "average")

# Plot the dendrograms
par(mfrow = c(2, 2))
# Save the plots to files
png("ward_method_dendrogram_w.png")
plot(agnes_ward, which.plot = 2, main = "Ward's Method")
dev.off()

png("single_linkage_dendrogram_w.png")
plot(agnes_single, which.plot = 2, main = "Single Linkage")
dev.off()

png("complete_linkage_dendrogram_w.png")
plot(agnes_complete, which.plot = 2, main = "Complete Linkage")
dev.off()

png("average_linkage_dendrogram_w.png")
plot(agnes_average, which.plot = 2, main = "Average Linkage")
dev.off()

