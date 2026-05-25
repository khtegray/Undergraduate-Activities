# DATA VISUALIZATION EXERCISES

# 1. Determine the relationship between temperature and ice cream sales.

# Data in excel (15 data):
# Temperature (°C) (randomize data between 30-45)
# Ice Cream Sales (randomize data between 100-200)

# Use Pearson's r to examine the correlation between temperature and sales.
install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/datavisualization.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Temperature = data_frame$`TEMPERATURE`
Ice_Cream_Sales = data_frame$`ICE CREAM SALES`
cor(Temperature,Ice_Cream_Sales)
# -0.1711079>0.05
# FALSE
# There is no relationship between temperature and sales.

# Data Visualization:
# SCATTER PLOT to visualize the relationship between temperature and sales.

# plot(data1 ~ data2, data = main_data)
plot(Temperature ~ Ice_Cream_Sales, data = data,
     xlab = "Temperature",
     ylab = "Ice Cream Sales",
     main = "Relationship between Temperature and Sales",
     pch = 20,
     cex = 2,
     col = "red")

# SMOOTED LINE PLOT to show the trend of ice cream sales as temperature increases.
install.packages("ggplot2")
library(ggplot2)

Temperature = data_frame$`TEMPERATURE`
Ice_Cream_Sales = data_frame$`ICE CREAM SALES`
cor(Temperature,Ice_Cream_Sales)

ggplot(data = data, aes(x = Temperature, y = Ice_Cream_Sales)) +
  geom_smooth(method = "auto", se = FALSE, color = "blue", linetype = "solid")


# 2. Investigate if the number of hours spent on social media per day affects 
#mental health scores.

# Data in excel (15 data):
# Hours on Social Media (randomize data between 1-20)
# Mental Health Score (randomize data between 1-10)

# Use Pearson's r to examine the correlation between hours on social media and 
#mental health scores.
excel_file = "C:/Users/HP/Downloads/datavisualization.xlsx"
sheet_name = "Sheet2"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Social_Media_Hours = data_frame$`SOCIAL MEDIA HOURS`
Mental_Health_Score = data_frame$`MENTAL HEALTH SCORE`
cor(Social_Media_Hours,Mental_Health_Score)

# Data Visualization:
# DOT PLOT to display the individual data points of social media usage and 
#mental health scores.
ggplot(data = data, aes(x = Mental_Health_Score, y = Social_Media_Hours)) +
  geom_point(color = "darkblue", size = 3, alpha = 0.5)

# BOX PLOT to show the distribution of mental health scores across different 
#hours of social media usage.
Social_Media_Hours = data_frame$`SOCIAL MEDIA HOURS`
Mental_Health_Score = data_frame$`MENTAL HEALTH SCORE`
cor(Social_Media_Hours,Mental_Health_Score)

# boxplot(data1 ~ data2, data = main_data)
boxplot(Social_Media_Hours ~ Mental_Health_Score, data = data,
        xlab = "Social Media Hours",
        ylab = "Mental Health Score",
        main = "Social Media vs Mental Health",
        col = "pink",
        border = "darkgreen")

# 3. Analyze if there is a significant difference in physical activity levels 
#between male and female students.

# Data in excel (15 data):
# Gender (randomize data between Male and Female)
# Physical Activity (hours/week) (randomize data between 1-20)

# Use Mann-Whitney U-Test to compare the physical activity levels between males
#and females.
excel_file = "C:/Users/HP/Downloads/datavisualization.xlsx"
sheet_name = "Sheet3"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Gender = data_frame$`GENDER`
Physical = data_frame$`PHYSICAL ACTIVITY`
observed = table(Gender, Physical)
wilcox.test(observed)

# Data Visualization:
# VIOLIN PLOT to compare the distribution of physical activity levels 
#across genders.
ggplot(data = data, aes(x = Gender, y = Physical)) +
  geom_violin(fill = "skyblue", color = "darkblue", alpha = 0.5) +
  
  labs(y = "Physical Activity")  # This changes the x-axis label

# BOX PLOT to show the range, median, and interquartile range of physical
#activity levels for both genders.
Gender = data_frame$`GENDER`
Physical = data_frame$`PHYSICAL ACTIVITY`
observed = table(Gender, Physical)
wilcox.test(observed)

# boxplot(data1 ~ data2, data = main_data)
boxplot(Gender ~ Physical, data = data,
        xlab = "Gender",
        ylab = "Physical Activity",
        main = "Interquartile Range of Physical Activity Levels for Genders",
        col = "pink",
        border = "darkgreen")

# 4. Analyze the impact of different diets on participants' blood sugar levels.
  
# Data in excel (15 data):
# Diet Type (randomize data between Low Carb, Vegan, Keto)
# Blood Sugar Level (mg/dL) (randomize data between 70-120)

# Use ANOVA to test if there is a significant difference in blood sugar levels 
#across diet types.
excel_file = "C:/Users/HP/Downloads/datavisualization.xlsx"
sheet_name = "Sheet4"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

diet_type = sample(c("Low Carb", "Vegan", "Keto"), size = 15, replace = TRUE)
blood_sugar = sample(70:120, size = 15, replace = TRUE)
data <- data.frame(DietType = diet_type, BloodSugar = blood_sugar)
print(data)

anova_result = aov(BloodSugar ~ DietType, data = data)
summary(anova_result)

# Data Visualization:
# BOX PLOT to show the distribution of blood sugar levels for each diet type.
DietType = data_frame$`DIET TYPE`
BloodSugarLevel = data_frame$`BLOOD SUGAR LEVEL`
observed = table(DietType, BloodSugarLevel)
wilcox.test(observed)

# boxplot(data1 ~ data2, data = main_data)
boxplot(DietType ~ BloodSugarLevel, data = data,
        xlab = "Diet Type",
        ylab = "Blood Sugar Level",
        main = "Blood Sugar Levels by Diet Type",
        col = "pink",
        border = "darkgreen")

# ADDITIONAL
diet_type <- sample(c("Low Carb", "Vegan", "Keto"), size = 15, replace = TRUE)
blood_sugar <- sample(70:120, size = 15, replace = TRUE)

# Create data frame
data <- data.frame(DietType = diet_type, BloodSugar = blood_sugar)

# View the data
print(data)

# Perform ANOVA
anova_result <- aov(BloodSugar ~ DietType, data = data)
summary(anova_result)

# Box plot
ggplot(data, aes(x = DietType, y = BloodSugar, fill = DietType)) +
  geom_boxplot() +
  labs(title = "Blood Sugar Levels by Diet Type",
       x = "Diet Type",
       y = "Blood Sugar Level (mg/dL)") +
  theme_minimal() +
  theme(legend.position = "none")

# BAR PLOT to compare the average blood sugar levels across diet types.
# Generate data
diet_type <- sample(c("Low Carb", "Vegan", "Keto"), size = 15, replace = TRUE)
blood_sugar <- sample(70:120, size = 15, replace = TRUE)

# Create data frame
data <- data.frame(DietType = diet_type, BloodSugar = blood_sugar)

# Calculate average blood sugar per diet type
avg_data <- data %>%
  group_by(DietType) %>%
  summarise(AverageSugar = mean(BloodSugar))

# View summary
print(avg_data)

# Create bar plot
ggplot(avg_data, aes(x = DietType, y = AverageSugar, fill = DietType)) +
  geom_bar(stat = "identity", width = 0.6) +
  labs(title = "Average Blood Sugar Level by Diet Type",
       x = "Diet Type",
       y = "Average Blood Sugar Level (mg/dL)") +
  theme_minimal() +
  theme(legend.position = "none")

# 5. Evaluate the effect of sleep duration on work productivity.

# Data in excel (15 data):
# Sleep Duration (hours) (randomize data between 1-10)
# Productivity Score (randomize data between 1-10)

# Use Pearson's r to analyze the relationship between sleep duration and productivity.
excel_file = "C:/Users/HP/Downloads/datavisualization.xlsx"
sheet_name = "Sheet5"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Sleep = data_frame$`SLEEP DURATION`
Productivity = data_frame$`PRODUCTIVITY SCORE`
cor(Sleep, Productivity)

# Data Visualization:
# DENSITY PLOT to visualize the distribution of sleep duration and 
#productivity scores.
ggplot(data = data, aes(x = Sleep)) +
  geom_density(fill = "skyblue", color = "darkblue", alpha = 0.7) +
  labs(x = "Sleep Duration")

# BOX PLOT to compare productivity scores for different sleep duration.
Sleep = data_frame$`SLEEP DURATION`
Productivity = data_frame$`PRODUCTIVITY SCORE`
observed = table(Sleep, Productivity)
wilcox.test(observed)

# boxplot(data1 ~ data2, data = main_data)
boxplot(Sleep ~ Productivity, data = data,
        xlab = "Sleep Duration",
        ylab = "Productivity Score",
        main = "Productivity Scores for Different Sleep Duration",
        col = "pink",
        border = "darkgreen")