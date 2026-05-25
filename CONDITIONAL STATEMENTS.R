# CONDITIONAL STATEMENTS 03/06/2025

# ifelse for excel
data = c(1,2,8,9,10,11)

category = ifelse(data>=10, "High",
                  ifelse(data>=5 & data<=9, "Moderate", "Low"))

data.frame(data, category)

# F2F PROBLEM 1
#SALES = data_frame$`SALES AMOUNT`
#PERFORMANCE = ifelse(SALES<10000, "Standard Performer", "High Performer")
#MONTHLY = ifelse(SALES<10000, 20000, 40000)
#BONUS = MONTHLY + SALES
#data.frame(SALES, PERFORMANCE, MONTHLY, BONUS)

install.packages("readxl")
library(readxl)

excel_file = "C:/Users/HP/Downloads/book3.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

SALES = data_frame$'SALES AMOUNT'

PERFORMANCE = ifelse(SALES<10000, "Low Performer",
                  ifelse(SALES>=10000 & SALES<=15000, "Standard Performer", 
                         "High Performer"))

MONTHLY = ifelse(SALES<10000, 20000,
                 ifelse(SALES>= 10000 & SALES <= 15000, 40000, 60000))

BONUS = MONTHLY + SALES
data.frame(SALES, PERFORMANCE, MONTHLY, BONUS)

# PROBLEM FROM PPT
# If the sales amount is greater than Php 10,000, mark the employee as "High Performer"
#in the "Performance" column. Otherwise, mark them as "Standard Performer".
excel_file = "C:/Users/HP/Downloads/Book4.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Employee_ID = data_frame$'Employee ID'
Sales_Amount = data_frame$'Sales Amount'

Performance = ifelse(Sales_Amount>10000, "High Performer",
                     "Standard Performer")
data.frame(Employee_ID, Sales_Amount, Performance)

# PROBLEM 1
# Determine the blood pressure ranges for each category: 
#"Normal" if Systolic < 120 and Diastolic < 80
#"Prehypertension" if 120 <= Systolic < 140 or 80 <= Diastolic < 90
#"Hypertension" if Systolic >= 140 or Diastolic >= 90
excel_file = "C:/Users/HP/Downloads/SAMPLE.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

SYSTOLIC = data_frame$`Systolic Pressure` 
DIASTOLIC = data_frame$`Diastolic Pressure`

BLOOD_PRESSURE = ifelse(SYSTOLIC <120 & DIASTOLIC <80, "NORMAL",
                        ifelse(SYSTOLIC >=120 & SYSTOLIC <140 | 
                                 DIASTOLIC >=80 & DIASTOLIC <90, "PREHYPERTENSION",
                               "HYPERTENSION"))

data.frame(SYSTOLIC, DIASTOLIC, BLOOD_PRESSURE)

# PROBLEM 2
# Set the criteria for loan approval based on income and credit score: 
#"Approved" if Income >= 40,000 and Credit Score >= 650
#"Rejected" otherwise

INCOME = data_frame$Income
CREDIT_SCORE = data_frame$'Credit Score'

LOAN_STATUS = ifelse(INCOME >=40000 & CREDIT_SCORE >=650, "APPROVED", "REJECTED")
data.frame(INCOME, CREDIT_SCORE, LOAN_STATUS)

# PROBLEM 3
# Set the criteria for customer segmentation based on the number of purchases:
#"Frequent Buyers" for customers with 10 or more purchases
#"Occasional Buyers" for customers with 5 to 9 purchases
#"Rare Buyers" for customers with less than 5 purchases

Purchases = data_frame$'Number of Purchases'

Customer_Category = ifelse(Purchsases>=10, "Frequent Buyers",
                           ifelse(Purchases>=5 & Purchases<=9, "Occasional Buyers",
                                  "Rare Buyer"))
data.frame(Purchases, Customer_Category)

# PROBLEM 4
# Set the rating ranges for each category: 
#"Highly Rated" for average ratings 4.0 and above
#"Moderately Rated" for average ratings between 3.0 and 3.9 
#"Low Rated" for average ratings below 3.0

Movie = data_frame$Movie
Rating = data_frame$'Average Rating'

Category = ifelse(Rating>=4.0, "Highly Rated",
                  ifelse(Rating>= 3.0 & Rating<=3.9, "Moderately Rated",
                         "Low Rated"))
data.frame(Movie, Rating, Category)


AGE = data_frame$AGE
AGE_GROUP = data_frame$'AGE GROUP'
MONTHLY = data_frame$MONTHLY
ANNUALLY = data_frame$ANNUALLY

ANNUALLY_PREMIUM_INSURANCE = ifelse(ANNUALLY>=60, "1000",
                                    ifelse(ANNUALLY >=18 & ANNUALLY <=59, "3000", "7000"))

data.frame(AGE, AGE_GROUP, MONTHLY, ANNUALLY, ANNUALLY_PREMIUM_INSURANCE)

# PRACTICE EXERCISE
#TEMPERATURE WARNING SYSTEM
#Temperature Category
#Set the temperature ranges for each category:
#"Cold for temperature less than 10°C
#"Moderate" for temperatures between 10°C and 20°C
#"Hot" for temperature greater than or equal to 20°C
excel_file = "C:/Users/HP/Downloads/BOOK3 (1).xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

TEMP = data_frame$Temperature

CATEGORY = ifelse(TEMP<10, "COLD", 
                  ifelse(TEMP>=10 & TEMP<20, "MODERATE", "HOT"))

data.frame(TEMP, CATEGORY)