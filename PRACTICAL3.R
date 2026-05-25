install.packages("readxl")
library(readxl)
excel_file = "C:/Users/HP/Downloads/prac3.xlsx"
sheet_name = "Sheet1"
data_frame = read_excel(excel_file, sheet=sheet_name)
print(data_frame)

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

Population_Density = Population%/%Area

Data = c("Population", "Area")
data.frame(Data, Mean, Range, Variance, SD)

Classification = ifelse(Population_Density>=500,"Low Population Density",
                           ifelse(Population_Density>=100 & Population_Density<=500, "Moderate Population Density",
                                  "High Population Density"))

Data = c("Country", "Population", "Area")
data.frame(Country, Population, Population_Density, Classification)

data1 = data_frame$`Population`
data2 = data_frame$`Area`
cor(data1,data2)
# 0.260349 > 0.05
#REJECT THE NULL HYPOTHESIS
#There is correlation between the population and the area.

install.packages("writexl")
library(writexl)

data_frame$Category = Category
write_xlsx(new_data, "D:/COMP2/SAMPLE1.xlsx")