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
data <- read_excel("datasets/demographics_encoded.xlsx")

# --------------Hierarchical Clustering----------------
# Distance metrics to explore
distance_metrics <- c("euclidean", "manhattan", "maximum", "canberra", 'gower')


# Try different linkage methods
agnes_ward <- agnes(data, method = "ward")
agnes_single <- agnes(data, method = "single")
agnes_complete <- agnes(data, method = "complete")
agnes_average <- agnes(data, method = "average")

# Plot dendrograms for comparison
par(mfrow = c(2, 2))
plot(agnes_ward, which.plot = 2, main = "Ward's Method")
plot(agnes_single, which.plot = 2, main = "Single Linkage")
plot(agnes_complete, which.plot = 2, main = "Complete Linkage")
plot(agnes_average, which.plot = 2, main = "Average Linkage")

# Evaluate using silhouette scores (example with Ward's method)
num_clusters <- 4
cluster_labels <- cutree(as.hclust(agnes_ward), k = num_clusters)
sil_ward <- silhouette(cluster_labels, dist(data))

mean(sil_ward[, 3]) # Mean silhouette score for Ward's method

# Repeat the silhouette calculation for other methods if needed
