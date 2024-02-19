
library(readr)
library(ggplot2)
library(gridExtra)

library(readr)
library(ggplot2)
library(dplyr)
library(gridExtra)

# Read the dataset from the provided URL
url <- "https://raw.githubusercontent.com/filhoalm/ITEB-breast-cancer/main/survival_article/data/seer22_race_er.csv"
df <- read_csv(url)
names(df)<-c("age", "year", "race","er", "rate", "cases", "py")
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
df_a$year <- as.numeric(df_a$year) + 1999
df1<-df_a
df2<-subset(df1, df1$age >=40 & df1$age <=84)
df_a <- df %>%
  group_by(age, year, er) %>%
  summarise(total_cases = sum(cases), .groups = 'drop')

# Display the first few rows of the data to understand what we are working with
# Group data by age and year to calculate observed counts and probabilities

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
df2_summary$Estimated_Positive<-round(df2_summary$Estimated_Positive, 0)
df2_summary$Estimated_Negative<-round(df2_summary$Estimated_Negative, 0)

# You may want to save the updated summary dataframe with estimations
#write.csv(df2_summary, 'df2_summary_with_estimations.csv', row.names = FALSE)

dat<-subset(df2_summary, df2_summary$year >= 2010)


# Create a long format
#df2_summary$Estimated_Positive<-as.numeric(df2_summary$Estimated_Positive)
#df2_summary$Estimated_Negative<-as.numeric(df2_summary$Estimated_Negative)



# Population
df <- read_csv("C:/Users/filhoam/Desktop/Breast/survival_article/data/seer22_py.csv")
head(df)

names(df)<-c("year", "age", "rate", "cases", "py")
df$year <- as.numeric(df$year) + 1999
df2<-subset(df, df$age >=40 & df$age <=84)
df2<-subset(df, df$age >=40 & df$age <=84 & df$year >=2000)
head(df2)

#
df4<-merge(dat, df2, by=c("year", "age"))


#check rates
names(df4)
df4$rate2<-(df4$total_cases / df4$py)*100000
# create rate objects

df5<-df4[c(1,2,3,4,9,10,13)]
head(df5)


# 3 = total_positive
# 4 = total_negative
# 5 = Estimated_Positive
# 6 = Estimated_Negative

df6<-df5[c(1,2,6,7)]

# Reshape the data
# Reshape the data
reshaped_data <- reshape(df6,
                         idvar = "age",
                         timevar = "year", # This is the column you want to convert
                         direction = "wide")

head(reshaped_data)
data<-reshaped_data[c(-1)]
#names(reshaped_data)[names(reshaped_data) %in% variables_to_remove] <- paste("var", seq_along(variables_to_remove))


# Create a dataframe with a single row and the same number of columns as df2
summary_info <- data.frame(matrix(NA, ncol = length(data), nrow = 5))
colnames(summary_info) <- colnames(data)

# Fill in the summary information
summary_info[1, 1] <- "Title: Breast Cancer"
summary_info[2, 1] <- "Description: Estimated_negative"
summary_info[3, 1] <- "Start Year: 2010"               # Enter the actual Start Year if available
summary_info[4, 1] <- "Start Age: 40"                  # Enter the actual Start Age if available
summary_info[5, 1] <- "Interval (Years): 1"            # Enter the actual interval if available

# Combine the summary information with the data
combined <- rbind(summary_info, data)

# View the combined data
head(combined)
#write.csv(combined, "C:/Users/filhoam/Desktop/Breast/survival_article/rates/estimated_negative.csv", row.names = FALSE)

################################

my_path <- "C:/Users/filhoam/Desktop/NCI/APC/SIP 2022/SIP 2022/RCode/All/"
setwd(my_path)  
functions <- list.files(pattern = "*.R")       # Get all file names
apc<- lapply(functions, source)  # Read all data frames

library(ggpubr)
# Note: You will need to install all packages prior to loading them.
packages <- c("dplyr",
              "ggplot2",
              "ggpubr",
              "ggthemes",
              "gridExtra",
              "hrbrthemes",
              "patchwork",
              "Matrix",
              "pracma",
              "scales",
              "RColorBrewer")

# Load
lapply(packages, require, character.only = TRUE)

#```{r setup1, echo=FALSE}
my_path <- "C:/Users/filhoam/Desktop/NCI/Kidney/DATA/"
setwd(my_path)  
dat1 <- csv2rates('C:/Users/filhoam/Desktop/Breast/survival_article/rates/observed_positive.csv')
dat2 <- csv2rates('C:/Users/filhoam/Desktop/Breast/survival_article/rates/observed_negative.csv')
dat3 <- csv2rates('C:/Users/filhoam/Desktop/Breast/survival_article/rates/estimated_positive.csv')
dat4 <- csv2rates('C:/Users/filhoam/Desktop/Breast/survival_article/rates/estimated_negative.csv')

# To visualize all objects
# Lets create a lexis diagram
a<-lexis(df1,legend.title.size=1)
b<-lexis(df2,legend.title.size=1)
c<-lexis(df3,legend.title.size=1)
d<-lexis(df4,legend.title.size=1)

#wrap_plots(list(a,b), 1, 2)
grid.arrange(a,b,c,d, ncol=2,nrow=2, top = "Kidney cancer")

#```
#```{r setup2, echo=FALSE}
M1 <- apc2fit(dat1)
M2 <- apc2fit(dat2)
M3 <- apc2fit(dat3)
M4 <- apc2fit(dat4)

# P curve function can Plot a selected output from an age-period-cohort model. 
# To update size of labels and change x,y labels

M1$FittedTemporalTrends

m1<-as.data.frame(M1$FittedTemporalTrends)
m1$index<-"observed_positive"

m2<-as.data.frame(M2$FittedTemporalTrends)
m2$index<-"observed_negative"

m3<-as.data.frame(M3$FittedTemporalTrends)
m3$index<-"estimated_positive"

m4<-as.data.frame(M4$FittedTemporalTrends)
m4$index<-"estimated_negative"


dat5<-rbind(m1, m2, m3, m4)

write.csv(dat5, "C:/Users/filhoam/Desktop/Breast/survival_article/rates/fitted_temporal_er.csv", row.names = FALSE)


ggplot(dat5, aes(x = Period, y = Rate, group = index, color = index)) +
  geom_line(aes(linetype=index, color=index)) +
  geom_point(aes(shape = index)) + # Point size
  xlim(2000,2020)+
  #scale_color_manual(values = c("darkblue", "darkblue", "darkred", "darkred")) + # Replace with desired colors
  theme_minimal() + # Lance style typically implies a minimalistic theme
  labs(
    title = "",
    x = "Year of diagnosis",
    y = "Crude rates per 100,000"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the plot title
    text = element_text(size = 12), # Change text size as needed
    aspect.ratio = 2.5 # Adjust this value to make the figure skinnier or wider
  )



