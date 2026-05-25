install.packages("readxl")
library(readxl)

excel_file = "C:/Users/HP/Downloads/Book5.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Class_Attendance = data_frame$'Class Attendance'
Internet_Speed = data_frame$'Internet Speed'
Productivity_Scores = data_frame$'Productivity Scores'
Advertising_Costs = data_frame$'Advertising Costs'
Survey_Scores = data_frame$'Survey Scores'

crange = max(Class_Attendance) - min(Class_Attendance)
irange = max(Internet_Speed) - min(Internet_Speed)
prange = max(Productivity_Scores) - min(Productivity_Scores)
arange = max(Advertising_Costs) - min(Advertising_Costs)
srange = max(Survey_Scores) - min(Survey_Scores)
RANGE = c(crange, irange, prange, arange, srange)

cmean = round((mean(Class_Attendance)),2)
imean = round((mean(Internet_Speed)),2)
pmean = round((mean(Productivity_Scores)),2)
amean = round((mean(Advertising_Costs)),2)
smean = round((mean(Survey_Scores)),2)
MEAN = c(cmean, imean, pmean, amean, smean)

cmedian = round((median(Class_Attendance)),2)
imedian = round((median(Internet_Speed)),2)
pmedian = round((median(Productivity_Scores)),2)
amedian = round((median(Advertising_Costs)),2)
smedian = round((median(Survey_Scores)),2)
MEDIAN = c(cmedian, imedian, pmedian, amedian, smedian)

cvar = round((var(Class_Attendance)),2)
ivar = round((var(Internet_Speed)),2)
pvar = round((var(Productivity_Scores)),2)
avar = round((var(Advertising_Costs)),2)
svar = round((var(Survey_Scores)),2)
VARIANCE = c(cvar, ivar, pvar, avar, svar)

csd = round((sd(Class_Attendance)),2)
isd = round((sd(Internet_Speed)),2)
psd = round((sd(Productivity_Scores)),2)
asd = round((sd(Advertising_Costs)),2)
ssd = round((sd(Survey_Scores)),2)
SD = c(csd, isd, psd, asd, ssd)

DATA = c("Class_Attendance", "Internet_Speed", "Productivity_Scores", "Advertising_Costs", "Survey_Scores")
data.frame(DATA, RANGE, MEAN, MEDIAN, VARIANCE, SD)

# PROBLEM 2
excel_file = "C:/Users/HP/Downloads/Book6.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

AGE = data_frame$AGE
AGE_GROUP = data_frame$'AGE GROUP'
ANNUALLY = data_frame$ANNUALLY

MONTHLY = ifelse(AGE>=60, "7000",
                        ifelse(AGE >=18 & AGE <=59, "3000", "1000"))

data.frame(AGE, AGE_GROUP, MONTHLY, ANNUALLY)