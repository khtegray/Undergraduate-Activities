install.packages("lubridate")
library(lubridate)

# Dataset
signup_data = data.frame(
  user_id = 1:5,
  signup_date = c("2025-04-07", "04/08/2025", "April 10, 2025", "20250411", "04-11-2025"),
  stringsAsFactors = FALSE)
print(signup_data)

signup_data$signup_clean = parse_date_time(signup_data$signup_date,
  orders = c("ymd", "mdy", "B d, Y", "dmy", "Ymd"))
print(signup_data)

signup_data$weekday = wday(signup_data$signup_clean, label = TRUE)
signup_data$month = month(signup_data$signup_clean, label = TRUE)
signup_data$day = day(signup_data$signup_clean)
print(signup_data)

install.packages("ggplot2")
library(ggplot2)

signup_data$weekday <- wday(signup_data$signup_clean, label = TRUE)

# Count by weekday
weekday_counts <- as.data.frame(table(signup_data$weekday))
names(weekday_counts) <- c("weekday", "signups")

# Plot
ggplot(weekday_counts, aes(x = weekday, y = signups)) +
  geom_col(fill = "#fdb863") +
  labs(
    title = "User Sign-Ups by Weekday",
    x = "Weekday",
    y = "Number of Sign-Ups"
  ) +
  theme_minimal()

install.packages("anytime")
library(anytime)

login_data = data.frame(
  user_id = 1:5,
  signup_date = c("2025-04-07 14:30", "04/08/2025 2:30 PM", "April 10, 2025 14:30:00", 
                  "20250411 1430", "Friday, 04-11-2025 02:30"),
  stringsAsFactors = FALSE)
print(login_data)

login_data$login_clean = anytime(login_data$login_time)
print(login_data)