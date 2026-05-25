# APPLIED STATS 03/27/2025

# If p-value < a (0.05):Decision: Reject the null hypothesis.
# If p-value ≥ a (0.05):Decision: Fail to reject the null hypothesis.

#T-TEST
#sample size is small
#population sd is not available
install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "ONE T-TEST"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

#One Sample
# Null Hypothesis: The average satisfaction level of employees
# in a company is 75 on a scale of 0 to 100
data = data_frame$`EMPLOYEE SATISFACTION`
t.test(data)
#p-value = 2.2e-16
#2.2e-16 < 0.05 = TRUE
#REJECT THE NULL HYPOTHESIS

#Sample 2
# Null Hypothesis: The average weight of a product should be 250 grams
data = data_frame$`PRODUCT WEIGHTS`
t.test(data)
#2.2e-16<0.05 = TRUE
#REJECT THE NULL HYPOTHESIS

# Null Hypothesis: There is no significant difference between the average
# satisfaction score of the customer and a specified benchmark or reference value.
data = data_frame$`CUSTOMER RATING`
t.test(data)
#8.034e-11<0.05 = TRUE
#REJECT THE NULL HYPOTHESIS

#TWO SAMPLE T-TEST
#compare the means of two different sample
install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "TWO T-TEST"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

#two test
# Null Hypothesis: There is no significant difference in the mean exam scores 
# before and after the intervention.
PRE = data_frame$'PRE-SCORES'
POST = data_frame$'POST-SCORES'
t.test(PRE, POST)

#PEARSON CORRELATION COEFFICIENT (R)
#between -1 and 1
#measures the strength of the relationship between two variables
# cor(group1, group2)
excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "PEARSON R"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

# Null Hypothesis: There is no significant correlation between customer 
# satisfaction and loyalty scores.
data1 = data_frame$`CUSTOMER SATISFACTION`
data2 = data_frame$`LOYALTY SCORES`
cor(data1,data2)
#p-value = 0.0200107
#0.0200107<0.05 = TRUE
#REJECT THE NULL HYPOTHESIS
# There is significant relationship between the customer satisfaction
# and loyalty scores.

#Null Hypothesis: There is no significant correlation between 
# employee training hours and performance
data1 = data_frame$`TENURE`
data2 = data_frame$`PERFORMANCE`
cor(data1,data2)
#-0.02061042<0.05 = TRUE
#REJECT THE NULL HYPOTHESIS

#ANALYSIS OF VARIANCE (ANOVA)
#more than two sample groups
excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "ANOVA"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

# Null Hypothesis: There is no significant difference in user engagement across 
# different social media platforms.
data1 = data_frame$FACEBOOK
data2 = data_frame$TWITTER
data3 = data_frame$INSTAGRAM
length_data = length(data1)

data = c(data1, data2, data3)
social_media = rep(c("FACEBOOK", "TWITTER", "INSTAGRAM"),147)

summary(aov(data~social_media))
#p-value = 0.579
#0.579 < 0.05 = FALSE
#FAIL TO REJECT THE NULL HYPOTHESIS
# There is no significant difference in user engagement across 
# different social media platforms.

#sample 2
data1 = data_frame$EDUCATION
data2 = data_frame$TECHNOLOGY
data3 = data_frame$HEALTH
data4 = data_frame$FINANCE
datlength_data = length(data1)

salary = c(data1, data2, data3, data4)
sector = rep(c("EDUCATION", "TECHNOLOGY", "HEALTH", "FINANCE"), length_data)

summary(aov(salary~sector))

#CHI-SQUARE TEST
#non parametric test
#test of independence of two variables
excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "CHI-SQUARE"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

# Null Hypothesis: There is no association between sex and toy preference 
# among children.
sex = data_frame$SEX
toy = data_frame$TOY

data = table(sex, toy)
chisq.test(data)
#0.9217 < 0.05 = FALSE
#FAIL TO REJECT THE NULL HYPOTHESIS
# There is no association between sex and toy preference among children.

#MANN-WHITNEY U-TEST
# Null Hypothesis: There is no difference in music preference between 
# teenagers and adults.

excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "MANW"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

data1 = data_frame$TEENAGERS
data2 = data_frame$ADULTS

observed = table(data1,data2)
wilcox.test(observed)

#KRUSKAL-WALLIS H-TEST
#comparing two or more independent samples of equal or different sample sizes

# Null Hypothesis: There is no difference in pain relief among 
# three different painkillers.

excel_file = "C:/Users/HP/Downloads/APPLIED STAT.xlsx"
sheet_name = "KRUSKAL"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

data1 = data_frame$`PAIN-A`
data2 = data_frame$`PAIN-B`
data3 = data_frame$`PAIN-C`

all_data<-list(data1,data2,data3)
kruskal.test(all_data)


Data = c("Country", "Population", "Area")
data.frame(Data, Mean, Range, Variance, SD)

Country = data_frame$Country
Population = data_frame$Population
Area = data_frame$Area
Population_Density = round((Population/Area),2)

pmean = round((mean(Population)),2)
amean = round((mean(Area)),2)
Mean = c(pmean, amean)

prange = max(Population) - min(Population)
arange = max(Area) - min(Area)
Range = c(prange, arange)

pvar = round((var(Population)),2)
avar = round((var(Area)),2)
Variance = c(pvar, avar)

psd = round((sd(Population)),2)
asd = round((sd(Area)),2)
SD = c(psd, asd)

Population_Density = round((Population/Area),2)

Classification = ifelse(Population_Density>=500, "Moderate Population Density",
                        ifelse(Purchases>=100 & Purchases<=500, "Low Population Density", 
                               "High Population Density"))
data.frame(Population_Density, Classification)

Data = c("Country", "Population", "Area")
data.frame(Country, Population, Population_Density, Classification)

Population_Density = round

Classification = ifelse(Population_Density>=500, "Moderate Population Density",
                        ifelse(Purchases>=100 & Purchases<=500, "High Population Density", 
                               "Low Population Density"))

#use > in p-value