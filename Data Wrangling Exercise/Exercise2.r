#Load the data in RStudio
df1 <- read.csv("C:/Irene/Springboard Study Folder/Exercises/titanic_original.csv", header = TRUE)

library(tidyr)
library(dplyr)
library(stringr)

#Port of embarkation: replace the blank value with "S"
any(is.na(df1$embarked)) #check if there's any NAs
df1$embarked[df1$embarked==""] <- "S"
df2 <- df1

#Age
mean <- mean(df2$age, na.rm = TRUE)
index <- which(is.na(df2$age))
df2$age[index] <- mean
any(df2$age=="")
df3 <- df2
## maybe we could group the people by different gender and calculate the mean age for different groups?

#Lifeboat: find the empty values in boat column and replace them with NA
boat_index <- which(df3$boat == "")
df3$boat[boat_index] <- NA
df4 <- df3

#Cabin
df5 <- df4 %>% 
  mutate(has_cabin_number = as.numeric(cabin!=""))

#Save the output as titanic_clean.csv
write.csv(df5, file="C:/Irene/Springboard Study Folder/Exercises/titanic_clean.csv", row.names=FALSE)








