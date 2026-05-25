# DATA FRAME 02/06/2025

install.packages("readxl")
library(readxl)

# book1
excel_file = "C:/Users/HP/Downloads/book1.xlsx"
sheet_name = "sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

Quarter = c("Quarter1", "Quarter2", "Quarter3", "Quarter4")
Q1_mean = mean(data_frame$Q1)
Q2_mean = mean(data_frame$Q2)
Q3_mean = mean(data_frame$Q3)
Q4_mean = mean(data_frame$Q4)

Mean = c(Q1_mean, Q2_mean, Q3_mean, Q4_mean)
print(Mean)

Verbal = cut(Mean, breaks = c(1, 1.49, 2.49, 3.49, 4.49, 5), 
             labels = c("Very Not Satisfied", "Not Satisfied", "Neutral", "Satisfied", "Very Satisfied"))
data.frame(Quarter=Quarter, Mean=Mean, Interpretation=Verbal)

# F2F PRACTICE
# book2
excel_file = "C:/Users/HP/Downloads/book2.xlsx"
sheet_name = "sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

SEX = data_frame$SEX
REMARKS_1 = cut(MATH, breaks = c(74,80, 85, 90, 95, 100),
                labels = c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT"))
REMARKS_2 = cut(ENG, breaks = c(74,80, 85, 90, 95, 100),
                labels = c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT"))
REMARKS_3 = cut(FIL, breaks = c(74,80, 85, 90, 95, 100),
                labels = c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT"))
REMARKS_4 = cut(STAT, breaks = c(74,80, 85, 90, 95, 100),
                labels = c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT"))
REMARKS_5 = cut(COM, breaks = c(74,80, 85, 90, 95, 100),
                labels = c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT"))

data.frame(SEX, MATH, REMARKS_1, ENG, REMARKS_2, FIL, REMARKS_3, STAT, 
           REMARKS_4, COM, REMARKS_5)

#RANGE
mrange = max(MATH) -min(MATH)
erange = max(MATH) -min(ENG)
frange = max(MATH) -min(FIL)
srange = max(MATH) -min(STAT)
crange = max(MATH) -min(COM)
RANGE = c(mrange, erange, frange, srange, crange)
SUBJECTS = c("MATH", "ENG", "FIL", "STAT", "COM")
data.frame(SUBJECTS, RANGE)

# PRACTICE EXERCISE
# table(data)
table(data_frame$SEX)

# data
SEX = data_frame$SEX
MATH = data_frame$MATH
ENG = data_frame$ENG
FIL = data_frame$FIL
STAT = data_frame$STAT
COM = data_frame$COM
# cut(data, breaks, labels)
breaks = c(74, 80, 85, 90, 95, 100)
labels= c("POOR", "FAIR", "GOOD", "VERY GOOD", "EXCELLENT")

REMARKS1 = cut(MATH, breaks, labels)
REMARKS2 = cut(ENG, breaks, labels)
REMARKS3 = cut(FIL, breaks, labels)
REMARKS4 = cut(STAT, breaks, labels)
REMARKS5 = cut(COM, breaks, labels)
data.frame(SEX, MATH, REMARKS1, ENG, REMARKS2, FIL, REMARKS3, STAT, REMARKS4,
           COM, REMARKS5)

# range(max(x) - min(x))
mrange = max(MATH) - min(MATH)
erange = max(ENG) - min(ENG)
frange = max(FIL) - min(FIL)
srange = max(STAT) - min(STAT)
crange = max(COM) - min(COM)
RANGE = c(mrange, erange, frange, srange, crange)

# mean(x)
mmean = round((mean(MATH)),2)
emean = round((mean(ENG)),2)
fmean = round((mean(FIL)),2)
smean = round((mean(STAT)),2)
cmean = round((mean(COM)),2)
MEAN = c(mmean, emean, fmean, smean, cmean)

# median(x)
mmedian = round((median(MATH)),2)
emedian = round((median(ENG)),2)
fmedian = round((median(FIL)),2)
smedian = round((median(STAT)),2)
cmedian = round((median(COM)),2)
MEDIAN = c(mmedian, emedian, fmedian, smedian, cmedian)

# variance(x)
mvar = round((var(MATH)),2)
evar = round((var(ENG)),2)
fvar = round((var(FIL)),2)
svar = round((var(STAT)),2)
cvar = round((var(COM)),2)
VARIANCE = c(mvar, evar, fvar, svar, cvar)

# standard deviation(x)
msd = round((sd(MATH)),2)
esd = round((sd(ENG)),2)
fsd = round((sd(FIL)),2)
ssd = round((sd(STAT)),2)
csd = round((sd(COM)),2)
SD = c(msd, esd, fsd, ssd, csd)

# Subjects
SUBJECTS = c("MATH", "ENGLISH", "FILIPINO", "STATISTICS", "COMPUTER")
data.frame(SUBJECTS, RANGE, MEAN, MEDIAN, VARIANCE, SD)