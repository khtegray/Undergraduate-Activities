#WRITE_XLSX 03/20/2025

install.packages("writexl")
library(writexl)

#saving of data
data_frame$CATEGORY = Category
write_xlsx(data_frame,"C:/Users/HP/Downloads/BOOK3 (1).xlsx")

# PRACTICE EXERCISE
#SOCIAL MEDIA ENGAGEMENT
#Engagement
#Set the criteria for each category:
#"Popular" if Likes + Shares is 150 or more
#"Not Popular" otherwise
install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/BOOK3 (1).xlsx"
sheet_name = "Sheet2"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Likes = data_frame$Likes
Shares = data_frame$Shares

criteria = ifelse(likes + shares>= 150, "POPULAR", "NOT POPULAR")
data.frame(likes, shares, criteria)

install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/SAMPLE.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

INCOME = data_frame$'Income'
CATEGORY = ifelse(INCOME > 5000, "RICH", "POOR")
data.frame(INCOME, CATEGORY)

install.packages("writexl")
library(writexl)

data_frame$CATEGORY = CATEGORY
write_xlsx(new_data,"C:/Users/HP/Downloads/BOOK3 (1).xlsx")