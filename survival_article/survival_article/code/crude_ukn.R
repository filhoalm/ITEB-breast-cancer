
library(readr)
library(ggplot2)
library(gridExtra)

df <- read_csv("C:/Users/filhoam/Desktop/Breast/survival_article/data/seer12_proportion_unk_race_er.csv")
names(df)<-c("year", "race", "er", "rate", "cases", "py")
df$year <- as.numeric(df$year) + 1991
# Check the result
df<-subset(df, df$year > 1991)
# Recode the race and stage values
df$race <- factor(df$race, levels = c(0, 1, 2, 3, 4, 5),
                    labels = c("NHW", "NHB", "AIAN", "API", "HIS", "Unknown"))
df$er[df$er==3]<-2
df$er <- factor(df$er, levels = c(0, 1, 2),
                  labels = c("Positive", "Negative", "Unknown"))

# Now, aggregate both cases and py by the new age groups as well as by race and subtype
data <- aggregate(cbind(cases, py) ~ race + year + er, data=df, sum)
# estimate the total number of er cases by year and race
estimated_cases <- aggregate(data$cases, by = list(data$race, data$year), sum)
names(estimated_cases)<-c("race", "year", "total")
df1<-merge(data, estimated_cases, by=c("race", "year"))
df1$prop<-(df1$cases / df1$total)
head(df1)

#Create a line plot in Lance style

df2<-subset(df1, df1$er == "Unknown")
df3<-subset(df2, df2$race== "NHW"|df2$race=="NHB"|df2$race=="API"|df2$race=="HIS")

a<-ggplot(df3, aes(x = year, y = prop, group = race, color = race)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  ylim(0, 0.5) +
  scale_color_manual(values = c("NHW" = "darkblue", "NHB" = "darkred", "API" = "purple", "HIS" = "darkorange")) +
  labs(
    title = "ER",
    x = "Year",
    y = "% of Unknown ER"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    text = element_text(size = 12),
    aspect.ratio = 2.5,
    legend.position = "bottom",
    legend.text = element_text(size = 5), # This will reduce the legend text size
    legend.title = element_text(size = 6), # This will reduce the legend title size
    legend.key.size = unit(0.5, "cm") # This will reduce the size of the colored keys
  )


######
library(readr)
df <- read_csv("C:/Users/filhoam/Desktop/Breast/survival_article/data/seer12_proportion_ukn_race_subtype.csv")
names(df)<-c("year", "race", "subtype", "rate", "cases", "py")
df$year <- as.numeric(df$year) + 1991
head(df)

# Check the result
df<-subset(df, df$year > 1991)
# Recode the race and stage values
df$race <- factor(df$race, levels = c(0, 1, 2, 3, 4, 5),
                  labels = c("NHW", "NHB", "AIAN", "API", "HIS", "Unknown"))
#
df$subtype[df$subtype==5]<-4
unique(df$subtype)
df$subtype <- factor(df$subtype, levels = c(0, 1, 2, 3, 4),
                labels = c("HR+/HER2+", "HR-/HER2+", "HR+/HER2-", "HR-/HER2-", "Unknown"))

# Now, aggregate both cases and py by the new age groups as well as by race and subtype
data <- aggregate(cbind(cases, py) ~ race + year + subtype, data=df, sum)
# estimate the total number of er cases by year and race
estimated_cases <- aggregate(data$cases, by = list(data$race, data$year), sum)
names(estimated_cases)<-c("race", "year", "total")
df1<-merge(data, estimated_cases, by=c("race", "year"))
df1$prop<-(df1$cases / df1$total)
head(df1)

#Create a line plot in Lance style

df2<-subset(df1, df1$year >=2010 & df1$subtype == "Unknown")
df3<-subset(df2, df2$race== "NHW"|df2$race=="NHB"|df2$race=="API"|df2$race=="HIS")

b<- ggplot(df3, aes(x = year, y = prop, group = race, color = race)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  ylim(0, 0.5) +
  scale_color_manual(values = c("NHW" = "darkblue", "NHB" = "darkred", "API" = "purple", "HIS" = "darkorange")) +
  labs(
    title = "Subtype",
    x = "Year",
    y = "% of Unknown Subtype"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    text = element_text(size = 12),
    aspect.ratio = 2.5,
    legend.position = "bottom",
    legend.text = element_text(size = 5), # This will reduce the legend text size
    legend.title = element_text(size = 6), # This will reduce the legend title size
    legend.key.size = unit(0.5, "cm") # This will reduce the size of the colored keys
  )

###
grid.arrange(a,b,
             ncol=2,
             top = grid::textGrob('', gp=grid::gpar(fontsize=5)))




