library(knitr)
library(kableExtra)

# Define the updated table data
table_data <- data.frame(
  NumberSelected = c(2323651, 2309327, 1990346, 1990346, 1990346,
                     1990346, 1990346, 1990346, 1990346, 1629086,
                     1629086, 1629086, 1629086, 1629086, 1629086, 1626352),
  NumberExcluded = c(2918834, 14324, 318981, 0, 0,
                     0, 0, 0, 0, 361260,
                     0, 0, 0, 0, 2734, 0),
  Statement = c("{Age at Diagnosis...} = '35-39 years', '40-44 years'...",
                "Exclude death certificate or autopsy cases",
                "Select only malignant cancers",
                "Select only known age",
                "Exclude age values not in table",
                "Exclude Race and origin recode values not in table",
                "Exclude Sex values not in table",
                "Exclude State values not in table",
                "Exclude County values not in table",
                "First Primary Only (Sequence Number 0 or 1)",
                "Invalid vital status",
                "Unknown survival duration",
                "Calculation dates invalid",
                "Coded survival duration conflicts...",
                "Alive with no survival time",
                "Cases for which an expected rate could not be found")
)

# Calculate the proportions
table_data$ProportionExcluded <- table_data$NumberExcluded / table_data$NumberSelected

# Format the updated table using `kable`
elegant_table <- kable(table_data, format = "html", col.names = c("Number Selected", "Number Excluded", "Statement", "Proportion Excluded"),
                       align = c('r', 'r', 'l', 'r'), caption = "Case Exclusion Counts") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = F)

# Print the table to the console (if you're not using R Markdown)
print(elegant_table, format = "html")

# Add the proportion column to the existing data frame
table_data$ProportionExcluded <- (table_data$NumberExcluded / table_data$NumberSelected)*100

table_data$ProportionExcluded<-round(table_data$ProportionExcluded,1)

# Show the data frame with the new column
print(table_data)




# If you want to include the table in an R Markdown document, use this line instead
# elegant_table

# Total number of cases read (can be mentioned in text or as part of a narrative in an R Markdown document)
total_cases_read <- 5242485

# Total number of records used in the analysis (can be mentioned in text or as part of a narrative in an R Markdown document)
total_records_used <- 1626352
