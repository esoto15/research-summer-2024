# install.packages("cluster")
# install.packages("ggplot2")
# install.packages("ggdendro")
# install.packages("readxl")
# install.packages("openxlsx")
# install.packages("circlize")
# install.packages("pvclust")

library(cluster)
library(ggplot2)
library(ggdendro)
library(readxl)
library(openxlsx)
library(circlize)
library(pvclust)

data <- read_excel("datasets/anova-demographics-encoded.xlsx")
head(data)

agnes_result <- agnes(data, method = "ward", metric = "euclidean")

dendro <- as.dendrogram(agnes_result)

dendro_data <- dendro_data(dendro)
ggdendrogram(dendro_data, rotate = TRUE) + 
  labs(title = "Dendrogram of AGNES Clustering", x = "Sample index", y = "Height")

png("agg-a.png")
plot(agnes_result, which.plot = 2, main = "Dendrogram of AGNES Clustering")
dev.off()
# ----------------------------------------------------------------
# Convert the agnes result to a dendrogram
dend <- as.dendrogram(agnes_result)

# Customize the dendrogram using dendextend
dend <- dend %>%
   set("branches_k_color", k = 4) %>% # Color branches by clusters
   set("branches_lwd", 3) %>%        # Set branches width
   set("labels_cex", 2) %>%        # Set labels size
   set("nodes_pch", 19) %>%          # Set node point shape
   set("nodes_col", "blue")          # Set node point color

# Save the circular dendrogram to a PNG file
png("circular_dendrogram.png", width = 800, height = 800)
par(mar = rep(0, 4)) # Remove margins
circlize_dendrogram(dend)
dev.off()


num_clusters <- 4

cluster_labels <- cutree(as.hclust(agnes_result), k = num_clusters)

data$cluster <- cluster_labels

write.xlsx(data, "datasets/anova-demographics-encoded-with-clusters.xlsx", overwrite = TRUE)

head(data)

