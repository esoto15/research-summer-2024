# Install necessary packages (uncomment if needed)
# install.packages("klaR")
# install.packages("FactoMineR")
# install.packages("factoextra")

# Load necessary libraries
library(klaR)
library(FactoMineR)
library(factoextra)
library(readxl)

# Load your dataset
file_path <- "datasets/FoodInsecurity_Hispanic_Demographics_Tone_Preferences_Dataset.xlsx"
data <- read_excel(file_path)

# Convert all columns to factors (if not already categorical)
data[] <- lapply(data, as.factor)

# Set the number of clusters
num_clusters <- 3

# Perform K-modes clustering
set.seed(123)
kmodes_result <- kmodes(data, modes = num_clusters)

# Add cluster assignments to the original data
data$Cluster <- kmodes_result$cluster

# Perform MCA for visualization
mca_result <- MCA(data[,-ncol(data)], graph = FALSE)  # Exclude the 'Cluster' column from MCA

# Visualize the clusters using the MCA plot
fviz_cluster(list(data = mca_result$ind$coord, cluster = kmodes_result$cluster),
             geom = "point", ellipse.type = "convex", 
             palette = "jco", ggtheme = theme_minimal())

# Print the K-modes result for reference
print(kmodes_result)
