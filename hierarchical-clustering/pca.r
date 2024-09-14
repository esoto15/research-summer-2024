# Load necessary libraries
library(ggplot2)
library(readxl)  # To use read_excel

# Load your data
# Assuming 'data' is a data frame with your dataset
data <- read_excel("datasets/hierarchical_data.xlsx")

# Check if the data is numeric
# Remove or convert non-numeric columns if necessary

# Standardize the data (optional but recommended)
data_scaled <- scale(data)

# Run PCA
pca_result <- prcomp(data_scaled)

# Print summary of PCA
summary(pca_result)

# Plot the PCA results
# Create a data frame with the PCA results
pca_data <- as.data.frame(pca_result$x)

# Plot the first two principal components
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point() +
  labs(title = "PCA Result", x = "Principal Component 1", y = "Principal Component 2")

