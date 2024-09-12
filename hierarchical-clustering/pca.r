# Load necessary library
library(ggplot2)

# Load your data
# Assuming 'data' is a data frame with your dataset
data <- read.csv("path_to_your_data.csv")

# Standardize the data (optional but recommended)
data_scaled <- scale(data)

# Run PCA
pca_result <- prcomp(data_scaled, center = TRUE, scale. = TRUE)

# Print summary of PCA
summary(pca_result)

# Plot the PCA results
# Create a data frame with the PCA results
pca_data <- as.data.frame(pca_result$x)

# Plot the first two principal components
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point() +
  labs(title = "PCA Result", x = "Principal Component 1", y = "Principal Component 2")