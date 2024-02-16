# Load necessary library for data fetching
library(readr)
library(ggplot2)
library(dplyr)
library(gridExtra)

# Read the dataset from the provided URL
url <- "https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/Incidence/see12/seer12_er.csv"
df <- read_csv(url)
head(df)

names(df)<-c("age", "year", "er", "rate", "cases", "py")
unique(df$er)
df$er[df$er==3]<-2 

# Aggregate cases by age, year, and er
df_a <- df %>%
  group_by(age, year, er) %>%
  summarise(total_cases = sum(cases), .groups = 'drop')

# Recode the race and stage values
df_a$er <- factor(df_a$er, levels = c(0, 1, 2),
                labels = c("Positive", "Negative", "Unknown"))

# Filter out rows with "Year of diagnosis" in the 'year' column and convert to numeric
#df <- subset(df, df$year != "Year of diagnosis")
df_a$year <- as.numeric(df_a$year) + 1991
head(df_a)
unique(df_a$year)
df1<-df_a
head(df1)
df2<-subset(df1, df1$age >=40)
head(df2)

# Sum the number of ER cases by year and age
df_summary <- df2 %>%
  group_by(year, age) %>%
  summarise(total_cases = sum(total_cases), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group
df3<-merge(df_summary, df2, by=c("age", "year"))
# Sum the number of ER cases by year and age
df_s <- df2 %>%
  group_by(year, er) %>%
  summarise(total_cases = sum(total_cases), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group
# Sum the number of ER cases by year and age
df_s1 <- df2 %>%
  group_by(year) %>%
  summarise(total_cases = sum(total_cases), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group
df4<-merge(df_s, df_s1, by=c("year"))
# Proportion of unknown
df4$prop<-(df4$total_cases.x / df4$total_cases.y)
head(df4)

# Filter for 'Unknown' ER only
df_unknown_er <- df4 %>%
  filter(er == "Unknown")

df_unknown_er<-subset(df_unknown_er, df_unknown_er$year>=1992)

# Create a line plot in Lance style
a<-ggplot(df_unknown_er, aes(x = year, y = prop, group = 1)) +
  geom_line(color = "black", size = 1) +  # Change line color and size as needed
  ylim(0,0.5)+
  geom_point(color = "black", size = 2) + # Add points and customize their color and size as needed
  theme_minimal() + # Lance style typically implies a minimalistic theme
  labs(
    title = "Year at diagnosis",
    x = "Year",
    y = "% of Unknown ER"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the plot title
    text = element_text(size = 12) # Change text size as needed
  )


## Proportion Age at diagnosis

head(df2)
df2a<-subset(df2, df2$year>=1992 & df2$year <=2008) #1991 represents 1992-2020
head(df2a)
# Sum the number of ER cases by year and age
dfb <- df2a %>%
  group_by(age) %>%
  summarise(total_cases = sum(total_cases), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group
head(dfb)
# Sum the number of ER cases by year and age
dfc <- df2a %>%
  group_by(age, er) %>%
  summarise(total_cases = sum(total_cases), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group
head(dfc)
df4a<-merge(dfc, dfb, by=c("age"))

# Proportion of unknown
df4a$prop<-(df4a$total_cases.x / df4a$total_cases.y)
head(df4a)

# Filter for 'Unknown' ER only
df_age <- df4a %>%
  filter(er == "Negative")

# Create a line plot in Lance style
b<-ggplot(df_age, aes(x = age, y = prop, group = 1)) +
  geom_line(color = "black", size = 1) +  # Change line color and size as needed
  ylim(0,0.5)+
  geom_point(color = "black", size = 2) + # Add points and customize their color and size as needed
  theme_minimal() + # Lance style typically implies a minimalistic theme
  labs(
    title = "Age at diagnosis",
    x = "Age",
    y = "% ER Negative"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the plot title
    text = element_text(size = 12) # Change text size as needed
  )




grid.arrange(a,b,
             ncol=2,
             top = grid::textGrob('', gp=grid::gpar(fontsize=5)))
dev.off()


#####################



# Read the dataset from the provided URL
url <- "https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/Incidence/see12/seer12_er.csv"
df <- read_csv(url)
head(df)

names(df)<-c("age", "year", "er", "rate", "cases", "py")
unique(df$er)
df$er[df$er==3]<-2 

# Aggregate cases by age, year, and er
df_a <- df %>%
  group_by(age, year, er, py) %>%
  summarise(total_cases = sum(cases), .groups = 'drop')

# Recode the race and stage values
df_a$er <- factor(df_a$er, levels = c(0, 1, 2),
                  labels = c("Positive", "Negative", "Unknown"))

# Filter out rows with "Year of diagnosis" in the 'year' column and convert to numeric
#df <- subset(df, df$year != "Year of diagnosis")
df_a$year <- as.numeric(df_a$year) + 1991
head(df_a)

unique(df_a$year)
df1<-df_a
head(df1)
df2<-subset(df1, df1$age >=40)
head(df2)

#
# Display the first few rows of the data to understand what we are working with
head(df2)

# Group data by age and year to calculate observed counts and probabilities
library(dplyr)

df2_summary <- df2 %>%
  group_by(age, year) %>%
  summarise(
    total_positive = sum(total_cases[er == "Positive"]),
    total_negative = sum(total_cases[er == "Negative"]),
    total_known = total_positive + total_negative,
    total_cases = sum(total_cases)
  ) %>%
  ungroup()

# Calculate the observed probabilities for known ER status
df2_summary <- df2_summary %>%
  mutate(
    Observed_Probability_Positive = total_positive / total_known,
    Observed_Probability_Negative = total_negative / total_known
  )

# Estimate the true counts for ER-positive and ER-negative cases using the observed probabilities
df2_summary <- df2_summary %>%
  mutate(
    Estimated_Positive = Observed_Probability_Positive * total_cases,
    Estimated_Negative = Observed_Probability_Negative * total_cases
  )

# Display the resulting estimates
head(df2_summary)
df2_summary$Estimated_Positive<-round(df2_summary$Estimated_Positive, 0)
df2_summary$Estimated_Negative<-round(df2_summary$Estimated_Negative, 0)

# You may want to save the updated summary dataframe with estimations
#write.csv(df2_summary, 'df2_summary_with_estimations.csv', row.names = FALSE)



# Create a long format

head(df2_summary)

df2_summary$Estimated_Positive<-as.numeric(df2_summary$Estimated_Positive)
df2_summary$Estimated_Negative<-as.numeric(df2_summary$Estimated_Negative)




#write.csv(df2_summary, "C:/Users/filhoam/Desktop/Breast/Incidence/imputation/imputed.csv")

dat<-read.csv("C:/Users/filhoam/Desktop/Breast/Incidence/imputation/imputed.csv")
head(dat)

library(dplyr)

# Assuming your data frame is named df2_summary
df2_aggregated_by_year <- dat %>%
  group_by(year) %>%
  summarise(
    total_positive = sum(total_positive),
    total_negative = sum(total_negative),
    Estimated_Positive = sum(Estimated_Positive, na.rm = TRUE), # Replace with actual column name
    Estimated_Negative = sum(Estimated_Negative, na.rm = TRUE)  # Replace with actual column name
  )


head(df2_aggregated_by_year)


# Population
py <- read_csv("C:/Users/filhoam/Desktop/Breast/Incidence/imputation/py.csv")
head(py)
names(py)<-c("year", "rate", "counts", "py")
py$year <- as.numeric(py$year) + 1991
py1<-py[c(1,4)]
head(py1)

## Merge
df2_aggregated<-merge(df2_aggregated_by_year, py1, by=c("year"))

#

head(df2_aggregated)

df2_aggregatedA<-df2_aggregated[c(1,2,6)]
df2_aggregatedA$index<-"total_positive"

df2_aggregatedB<-df2_aggregated[c(1,3,6)]
df2_aggregatedB$index<-"total_negative"
names(df2_aggregatedB)[2]<-c("total_positive")

df2_aggregatedC<-df2_aggregated[c(1,4,6)]
df2_aggregatedC$index<-"Estimated_Positive"
names(df2_aggregatedC)[2]<-c("total_positive")

df2_aggregatedD<-df2_aggregated[c(1,5,6)]
df2_aggregatedD$index<-"Estimated_Negative"
names(df2_aggregatedD)[2]<-c("total_positive")



df2_long<-rbind(df2_aggregatedA, df2_aggregatedB, df2_aggregatedC, df2_aggregatedD)
head(df2_long)
names(df2_long)[2]<-c("cases")
unique(df2_long$index)

# rates

df2_long$rate<-(df2_long$cases / df2_long$py)*100000

## plot

long<-subset(df2_long, df2_long$year>=1992)

# Create a line plot in Lance style
c<-ggplot(long, aes(x = year, y = rate, group = index, color = index)) +
  geom_line(aes(linetype=index, color=index))+
  geom_point(aes(shape = index)) + # Point size
  scale_color_manual(values = c("darkblue", "darkblue", "darkred", "darkred")) + # Replace with desired colors
  theme_minimal() + # Lance style typically implies a minimalistic theme
  labs(
    title = "",
    x = "Year of diagnosis",
    y = "Crude rates per 100,000"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the plot title
    text = element_text(size = 12) # Change text size as needed
  )






grid.arrange(a,b,c,
             ncol=3,
             top = grid::textGrob('', gp=grid::gpar(fontsize=5)))
dev.off()















library(ggplot2)

# Assuming 'long' is your data frame and it is structured appropriately
# with columns `year`, `rate`, and `index`

# Create a line plot in Lancet style
ggplot(long, aes(x = year, y = rate, group = index, color = index)) +
  geom_line(size = 1) +  # Line size
  geom_point(size = 2) + # Point size
  scale_color_manual(values = c("darkblue", "darkblue", "darkred", "darkred")) + # Replace with desired colors
  theme_minimal() + # Lancet style typically implies a minimalistic theme
  labs(
    title = "Year of diagnosis",
    x = "Year of diagnosis",
    y = "Crude rates per 100,000"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the plot title
    text = element_text(size = 12), # Change text size as needed
    legend.position = "bottom", # Legend at the bottom
    legend.box = "vertical", # Align legend items vertically
    legend.spacing.y = unit(0.5, "cm") # Add some space between the legend entries and plot
  )
# Display the plot
print(p)












library(dplyr)

df2_aggregated_by_year <- dat %>%
  group_by(year) %>%
  summarise(
    total_positive = sum(total_positive, na.rm = TRUE),
    total_negative = sum(total_negative, na.rm = TRUE),
    total_known = sum(total_known, na.rm = TRUE),
    total_cases = sum(total_cases, na.rm = TRUE),
    Estimated_Positive = sum(Estimated_Positive, na.rm = TRUE), # Replace with actual column name
    Estimated_Negative = sum(Estimated_Negative, na.rm = TRUE)  # Replace with actual column name
    # ... Other summary functions on your variables ...
  )









#total_positive
dfa1<-df2_summary[c(1,2,3)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa1 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(total_positive), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa1)
dfa1$index<-"total_positive"

#total_negative
dfa1<-df2_summary[c(1,2,4)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa2 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(total_negative), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa2)
dfa2$index<-"total_negative"


#Estimated_Positive
dfa1<-df2_summary[c(1,2,9)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa4 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(Estimated_Positive), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa4)
dfa4$index<-"Estimated_Positive"




# Load the necessary library for data manipulation
library(dplyr)

# Assume dfa1 is your initial dataset (replace with the correct variable name if different)
dfa1 <- ... # Your dataset goes here

# Sum the number of ER cases by year
dfa4 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(Estimated_Positive), .groups = 'drop') # Sum of Estimated_Positive within each year

# Add an index column if needed (it is not clear what this index is for)
dfa4$index <- "Estimated_Positive"

# Check the first few rows of dfa4 to ensure the calculation is correct
head(dfa4)










#Estimated_Negative
dfa1<-df2_summary[c(1,2,10)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa5 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(Estimated_Negative), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa5)
dfa5$index<-"Estimated_Negative"




















######
dfa1<-df2_summary[c(1,2,5)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa3 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(total_known), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa3)
dfa3$index<-"total_known"


######
dfa1<-df2_summary[c(1,2,5)]
head(dfa1)

# Sum the number of ER cases by year and age
dfa3 <- dfa1 %>%
  group_by(year) %>%
  summarise(total_cases = sum(total_known), .groups = 'drop') # Sum of 'cases' within each 'year' and 'age' group


head(dfa3)
dfa3$index<-"total_known"















pop<-subset(df2, df2$er=='Positive')

df5<-merge(df2_summary, pop, by=c("age", "year"))

df5<-df5[c(-11,-13)]

df5$obs_pos_rate<-(df5$total_positive / df5$py)*100000
df5$obs_neg_rate<-(df5$total_negative / df5$py)*100000

df5$est_pos_rate<-(df5$Estimated_Positive / df5$py)*100000
df5$est_neg_rate<-(df5$Estimated_Negative / df5$py)*100000


# Aggregate number of cases by age


names(df5)
a<-df5[c()]






dfp<-as.data.frame(subset(df1, df1$er=="Positive"))
dfn<-as.data.frame(subset(df1, df1$er=="Negative"))
dfu<-as.data.frame(subset(df1, df1$er=="Unknown"))

df2<-merge(dfp,dfn, by=c("age", "year", "race"))


df3<-merge(df2,dfu, by=c("age", "year", "race"),all = FALSE, sort = TRUE)


#
head(df3)

names(df3)[6]<-c("er_positive")
names(df3)[10]<-c("er_negative")
names(df3)[14]<-c("unknown")

df3<-df3[c(1,2,3,6,10,14,15)]

head(df3)



df4<-subset(df3, df3$race == "NHW" & df3$age>=40 & df3$year>=2004)

df4$prop_unknown <- with(df4, unknown / (er_positive + er_negative + unknown))





breast_cancer_data<-subset(df4, df4$race == "NHW")

# Display the first few rows of the data to understand what we are working with
head(breast_cancer_data)

# Calculate the observed probabilities for known ER status
# Note: The column names are based on the dataset structure
breast_cancer_data$Observed_Probability <- with(breast_cancer_data, er_positive / (er_positive + er_negative))

# Estimate the true counts for ER-positive and ER-negative cancers using the observed probabilities
breast_cancer_data$Estimated_Positive <- with(breast_cancer_data, Observed_Probability * (er_positive + er_negative + unknown))
breast_cancer_data$Estimated_Negative <- with(breast_cancer_data, (1 - Observed_Probability) * (er_positive + er_negative + unknown))

# Display the resulting estimates
head(breast_cancer_data)

# You may want to save the updated dataframe with estimations
# write.csv(breast_cancer_data, 'breast_cancer_data_with_estimations.csv', row.names = FALSE)






