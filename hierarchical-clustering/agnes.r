# Install and load necessary packages
# install.packages("cluster")
# install.packages("ggplot2")
# install.packages("ggdendro")
# install.packages("readxl")
install.packages("lime")
install.packages("caret")
install.packages("randomForest")  # Example of a model package


library(cluster)
library(ggplot2)
library(ggdendro)
library(readxl)
install.packages("lime")
install.packages("caret")
install.packages("randomForest")  # Example of a model package

# load file
data <- read_excel("tones_encoded.xlsx")

# Check data structure
head(data)
# Apply AGNES clustering
agnes_result <- agnes(data, method = "ward", metric = "manhattan")

# Plot the dendrogram using base R plot function
plot(agnes_result, which.plots = 2)
fviz_dend(agnes_result, k = 4, # Cut in 4 groups
          cex = 0.5, # Label size
          horiz = TRUE, # Horizontal plot
          rect = TRUE, # Add rectangle around groups
          rect_fill = TRUE, # Fill rectangles
          rect_border = "jco", # Rectangle color
          k_colors = "jco") # Cluster color
# Convert the agnes object to a dendrogram object for better visualization
dendro <- as.dendrogram(agnes_result)

# Plot the dendrogram using ggplot2
dendro_data <- dendro_data(dendro)
ggdendrogram(dendro_data, rotate = TRUE) + labs(title = "Dendrogram of AGNES Clustering", x = "Sample index", y = "Height")

# ------Cluster Analysis------
# Agglomerative Coefficient VS Cophenetic Correlation Coefficient
# Agglomerative Coefficient: Specifically measures the strength and cohesiveness of clusters formed by an agglomerative clustering algorithm.
# Cophenetic Correlation Coefficient: Assesses how well the hierarchical clustering dendrogram preserves the pairwise distances from the original data.
