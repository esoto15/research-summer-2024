# Install necessary packages (only need to run if packages aren't installed yet)
# install.packages("cluster")
# install.packages("dendextend")
# install.packages("circlize")
# install.packages("ggplot2")
# install.packages("openxlsx")

# Load required libraries
library(cluster)     # For AGNES clustering
library(dendextend)  # For dendrogram customization
library(circlize)    # For circular dendrograms
library(ggplot2)     # For plotting
library(openxlsx)    # For saving Excel files

# Load your dataset (replace with the correct path)
data <- read.xlsx("datasets/anova-demographics-encoded.xlsx")

# Perform AGNES clustering
agnes_result <- agnes(data, method = "ward", metric = "euclidean")

# Convert the AGNES result to a dendrogram
dend <- as.dendrogram(agnes_result)

# Customize the dendrogram using dendextend
dend <- dend %>%
  set("branches_k_color", k = 4) %>%   # Color branches by clusters
  set("branches_lwd", 3) %>%           # Set branch line width
  set("labels_cex", 1.5) %>%           # Set label size
  set("nodes_pch", 19) %>%             # Set node point shape
  set("nodes_col", "blue")             # Set node point color

# Save the circular dendrogram to a PNG file
png("circular_dendrogram.png", width = 800, height = 800)
par(mar = rep(0, 4)) # Remove margins
circlize_dendrogram(dend)
dev.off()

# Set the number of clusters you want
num_clusters <- 7

# Cut the dendrogram tree to form 'num_clusters' clusters
cluster_labels <- cutree(as.hclust(agnes_result), k = num_clusters)

# Add the cluster labels to the dataset
data$Cluster <- cluster_labels

# Save the dataset with cluster labels as an Excel file
write.xlsx(data, "datasets/anova-demographics-encoded-with-clusters.xlsx", overwrite = TRUE)

# Generate a standard dendrogram (non-circular) and save as PNG
png("dendrogram_standard.png", width = 800, height = 600)
plot(agnes_result, which.plot = 2, main = "Dendrogram of AGNES Clustering")
dev.off()

# Visualize the clusters using ggplot2
cluster_plot <- ggplot(data, aes(x = data[, 1], y = data[, 2], color = factor(Cluster))) + 
  geom_point(size = 3) +
  labs(title = "Cluster Visualization", x = "Feature 1", y = "Feature 2", color = "Cluster") +
  theme_minimal()

# Save cluster plot as PNG
ggsave("cluster_visualization.png", plot = cluster_plot, width = 10, height = 8)

# Output the head of the dataset with cluster labels
head(data)
