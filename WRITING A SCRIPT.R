# WRITING A SCRIPT 01/30/25

# Example 1
print ("Hello World")

# Example 2
100:150

# Example 3: two commands in line
1 + (2*3): (4-1)^2

# Example 4: breaking a command into multiple lines
1 +
  (2*3)

# Example 5: grouping lines into 1 command using {}
{print(
  "hello world"
)}

# Note on Print ()
x <- "hello!"
x

x=1:100
print(x)

for (i in 1:10){
  print(x)
}

# Creating an R Object
Name=Value
Name<-Value

# DATA AND PROGRAMMING

# Vectors c() "combine"
x=c(2,4,6,8,10)
y=x+5
print(y)

# Paste Function
x=c(1,3,5,7,9)
y=paste("The odd numbers between 1 and 10 are ",x)
print(y)

x=c(1,3,5,7,9)
print(paste("The odd numbers between 1 and 10 are ",x))

# Vectors seq()
x=seq(1,100,5)
print(x)

x=seq(100,1,-5)
print(x)

# Vectors rep ()
name="Khate"
print(rep(name,3))

# PRACTICE EXERCISES 1
# Create two numeric variables a and b. Calculate their sum and print the result.
a=2
b=3
print(a+b)

# Create a character variable name and concentrate it with the string  
#"is a programmer". Print the concentrated string.
name="Jesh"
print(paste(name, "is a programmer."))

# Create a vector of numbers from 1 to 10. Square each element and print the result.
x=c(1:10)
print(x^2)

# Use the modulus operator to find the remainder when dividing 17 by 3. Print the result.
a=17
b=3
print(a%%b)

# Vectors Length
five <- 5
five

is.vector(five)

lenght(five)

# Vectors typeof
die <- c(1, 2, 3, 4, 5, 6)
typeof(die)

# Vectors Subsetting
x[3:6]

x=c(4,7,9,3,5,10,1,2,6)
print(x[3:5])

# Matrices
m <- matrix(1:6, nrow = 2)
m

matrix(x,ncol=3, byrow=TRUE)

name = c("My", "Ana", "Bea")
age = c(18, 10, 6)
cbind(Name=name, Age=age)

name = c("My", "Ana", "Bea")
age = c(18, 10, 6)
rbind(Name=name, Age=age)

# Create the following matrix, which stores the name and suit of every card in a royal flush.
x = c("ace", "king", "queen", "jack", "ten")
y = rep("spades",5)
cbind(x,y)

# PRACTICE EXERCISE 2
# Create a vector named numbers with values 1 to 5. 
#Calculate the sum of the vector numbers. Use the sum() function.
numbers=c(1:5)
print(sum(numbers))

# Create a matrix named my_matrix with two rows and three columns, containing values 1 to 6.
my_matrix=matrix(1:6,2,3)
print(my_matrix)

# Create a vector odds with odd numbers from 1 to 10.
odds=seq(1,10,2)
print(odds)

# Create two vectors: v1 = c(1,2,3) and v2 = c(4,5,6). Combine them into a single vector.
v1=c(1,2,3)
v2=c(4,5)
v3=c(v1,v2)
print(v3)

# Create a vector with elements 1,4,2,5,3. Calculate its mean, median, 
#and standard deviation (use mean(), median(), and sd() functions).
num=c(1,4,2,5,3)
print(paste("Mean: ",mean(num)))
print(paste("Median: ",median(num)))
print(paste("Standard Deviation: ",round((sd(num)),2)))

# PRACTICE EXERCISE 3
# Given base (5) and height (8) as numeric values, calculate the are of a 
#triangle using the formula (1/2) * base * height.
base = 5
height = 8
triangle = (1/2)*base*height
print(paste("Area of triangle: ",triangle))

# Create a vector with human ages (e.g., c(20, 35, 12) and convert them to 
#dog years using the formula dog_years = 15 + 4 * human_ages. Using cbind, combine the human_ages and dog years.
human_ages = c(20, 35, 12)
dog_years = 15+4*human_ages
cbind(human_ages, dog_years)

# Convert temperatures from Celsuis to Fahrenheit using 
#the formula fahrenheit = (celsuis * 9/5) + 32. Using rbind, combine the
#celsuis_values and fahrenheit_values.
celsius_values = c(25, 10, -5)
fahrenheit = (celsius_values*9/5)+32
rbind(celsius_values, fahrenheit_values)

# Given two vectors representing opening and closing stock prices for 5 days, 
#calculate the daily change (closing - opening) for each day.
opening_prices = c(100, 112, 98, 105, 110)
closing_prices = c(105, 108, 95, 107, 115)
daily_changes = c(5, -4, -3, 2, 5)
cbind(opening_prices, closing_prices, daily_changes)

#  Compute the Profit, Expenses, and Net Profit.
Number = c(1,2,3,4,5)
Description = c("Meat", "Milk", "Eggs", "Juice", "Water")
Quantity = c(10,20,32,12,15)
Capital = c(365,126,10,33,12)
Price = c(385,135,12,40,15)
Profit = Price*Quantity
data.frame(Number, Description, Quantity, Capital, Price, Profit)
Expenses = sum(Capital*Quantity)
Net_profit = Price*Quantity
cat(paste("Expenses:", Expenses))
cat(paste("Net Profit:", Net_profit))

# PRACTICAL 1
# two problems
Day = c(1, 2, 3, 4, 5)
daily_money = rep(200,5)
daily_expenses = c(150, 120, 160, 142, 98)
daily_savings = (daily_money - daily_expenses)
daily_savings_percentage = c(25, 40, 20, 29, 51)
data.frame(Day, daily_money, daily_expenses, daily_savings, 
           daily_savings_percentage)
cat(paste("Total Savings for the week:",sum(daily_savings)))

Loaned_Amount = seq(from = 30000, to = 100000, by = 1000)
For_1_year_Term = round(fixed_4_percent_interest, Loaned_Amount/12, 2)
Loaned_Amount = seq(from = 30000, to = 100000, by = 1000)