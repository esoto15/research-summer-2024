library(cluster)
library(ggplot2)
library(ggdendro)
library(readxl)
library(openxlsx)

# Load the data
data <- read_excel("datasets/demo-encoded.xlsx")

# Distance metrics to try
distance_metrics <- c("euclidean", "manhattan", "maximum", "canberra")

# Loop through each distance metric
for (metric in distance_metrics) {
  # Perform AGNES clustering with the current distance metric
  agnes_result <- agnes(data, method = "ward", metric = metric)
  
  # Extract the agglomerative coefficient
  agglomerative_coeff <- agnes_result$ac
  
  # Create dendrogram
  dendro <- as.dendrogram(agnes_result)
  dendro_data <- dendro_data(dendro)
  
  # Create dendrogram plot with agglomerative coefficient in the title
  dendro_plot <- ggdendrogram(dendro_data, rotate = TRUE) + 
    labs(title = paste("Dendrogram of AGNES Clustering -", metric, 
                       "\nAgglomerative Coefficient:", round(agglomerative_coeff, 3)), 
         x = "Sample index", y = "Height")
  
  # Print plot to view in RStudio
  print(dendro_plot)
  
  # Save plot as a PNG file
  ggsave(filename = paste("dendrogram_", metric, ".png", sep = ""), 
         plot = dendro_plot, 
         width = 8, height = 6)
  
  # Display the agglomerative coefficient
  cat("Agglomerative Coefficient for", metric, "distance:", agglomerative_coeff, "\n")
}
