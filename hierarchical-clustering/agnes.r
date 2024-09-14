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

# Load data
data <- read_excel("datasets/demographics_encoded.xlsx")

# Check data structure
head(data)

# Apply AGNES clustering
agnes_result <- agnes(data, method = "ward", metric = "manhattan")

# Convert the result to a dendrogram
dendro <- as.dendrogram(agnes_result)

# Plot the dendrogram using ggplot2
dendro_data <- dendro_data(dendro)
ggdendrogram(dendro_data, rotate = TRUE) + 
  labs(title = "Dendrogram of AGNES Clustering", x = "Sample index", y = "Height")
plot(dendro, main = "Dendrogram of AGNES Clustering")

# Determine the number of clusters
# Let's say we want to cut the dendrogram to form 4 clusters
num_clusters <- 4

# Cut the dendrogram to form clusters
cluster_labels <- cutree(as.hclust(agnes_result), k = num_clusters)

# Add the cluster labels to the dataset
data$cluster <- cluster_labels

# Check the updated data structure
head(data)

# Export the updated dataset to an Excel file
write.xlsx(data, "hierarchical-clustering/demo-encoded-with-clusters.xlsx")
