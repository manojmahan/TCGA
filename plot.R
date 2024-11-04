# Load necessary libraries
library(ggplot2)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
#print(args)


df_list <- list()

sample_types <- unlist(strsplit(args, split = ","))

for (sam_type in sample_types) {
  file_name <- gsub(" ", "", sam_type)
  file_name <- paste0(file_name, "_tpm.tsv")

  df <- read.table(file_name, header = TRUE, sep = "\t")
  

  df$sample_type <- sam_type
  

  df_list[[length(df_list) + 1]] <- df
}

# Combine all DataFrames into one
df_combined <- bind_rows(df_list)
#str(df_combined)

ggsave("ggplots/plot_stn_pt.pdf", 
       width = 6, height = 4,
       ggplot(df_combined, aes(x = sample_type, y = tpm)) +
         geom_boxplot(notch = TRUE) +
         labs(y = "Log2 (TPM + 1)", x = "") +
         theme_minimal() +
         coord_cartesian(ylim = c(0, 10))
)
