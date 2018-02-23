<center> <h1> Data Wrangling Process</h1> </center>
<center> <h4> Irene Yao </h4> </center>
<center> <h4> February 22, 2018 </h4> </center>

### **Issues Identified**
* Column names are separated by "." and include both uppercase and lowercase
* Animal type includes "Other", which we need to exclude from the analysis
* Sex column includes "Spayed" and "Neutered", which can be translated into "Female" and "Male"
* All date columns are read as characater strings in R
* Date of birth column has missing values and future dates
* Some Intake dates and Outcome dates are prior to Date of Birth, which is obviously wrong
* Size column has missing values
* Days in shelter column shows 0 for animals that are not adopted yet. Those cells should be empty
* Outcome type, Outcome subtype, and Outcome condition columns have empty cells; replace them with NA
* Outcome Jurisdiction, Zip Code & Location columns have missing values; replace them with NA
* Redundant Count column

### **Data Wrangling Steps**
#### **1. Read CSV File**
```{r message=FALSE}
df<-read.csv("C:/Irene/Springboard Study Folder/Capstone Project/Datasets/Animal_Shelter.csv", header=TRUE)
```

#### **2. Load R libraries**
```{r message=FALSE}
library(tidyr)
library(dplyr)
library(lubridate)
```

#### **3. Clean up column names by replacing \. with \_ and to lowercase**
```{r message=FALSE}
names(df) <- gsub(x = names(df), pattern = "\\.", replacement = "_") 
names(df) <- tolower(names(df))
```

#### **4. Subset the data to include only CAT and DOG**
```{r message=FALSE}
df <- filter(df, type=="DOG" | type=="CAT")
```

#### **5. Translate Spayed and Neutered into Female & Male and create a new sex column**
```{r message=FALSE}
df$sex_clean <- ifelse(df$sex=="Spayed", "Female", "Male")
```

#### **6. Change the date columns to Date class using lubridate**
```{r message=FALSE}
df$date_of_birth <- mdy(df$date_of_birth)
df$intake_date <- mdy(df$intake_date)
df$outcome_date <- mdy(df$outcome_date)
```

#### **7. Clean up the DOB column to remove future dates and change missing dates to NA**
```{r message=FALSE}
df$date_of_birth[df$date_of_birth > Sys.Date() & !is.na(df$date_of_birth)] <- NA
```

#### **8. Clean up the DOB column where DOB is later than the intake date**
```{r message=FALSE}
df$date_of_birth[df$date_of_birth>df$intake_date & !is.na(df$date_of_birth)] <- NA
```

#### **9. Fill up the missing values in size column**
a. make size equals Puppy or Kitten if animal is less than 1 year old upon arrival at the shelter
```{r message=FALSE}
df$size[df$type=="CAT" & (df$intake_date-df$date_of_birth < 365) & df$size=="" & !is.na(df$date_of_birth)] <- "KITTN"
df$size[df$type=="DOG" & (df$intake_date-df$date_of_birth < 365) & df$size=="" & !is.na(df$date_of_birth)] <- "PUPPY"
```
b. categorize the breed into different size classes and replace the missing values based on the breed
```{r message=FALSE}
toy <-c("CHIHUAHUA SH")
small <- c("BEAGLE", "CHIHUAHUA SH/MIX", "DOMESTIC SH", "PUG")
med <- c("BASSET HOUND/MIX", "BORDER COLLIE/MIX", "MCNAB")
large <- c("AMERICAN STAFF/PIT BULL", "GERM SHEPHERD", "GOLDEN RETR", "LABRADOR RETR", "LABRADOR RETR/MIX", "MAREMMA SHEEPDG", "ROTTWEILER/MIX")

df$size[df$breed %in% toy & df$size==""] <- "TOY"
df$size[df$breed %in% small & df$size==""] <- "SMALL"
df$size[df$breed %in% med & df$size==""] <- "MED"
df$size[df$breed %in% large & df$size==""] <- "LARGE"
```

#### **10. Remove the number 0 from days_in_shelter column if the animal is still in shelter**
```{r message=FALSE}
df$days_in_shelter[is.na(df$outcome_date)] <- NA
```

#### **11. Replace missing values in Outcome type, Outcome subtype, and Outcome condition with NA**
```{r message=FALSE}
df$outcome_type[df$outcome_type==""] <- NA
df$outcome_subtype[df$outcome_subtype==""] <- NA
df$outcome_condition[df$outcome_condition==""] <- NA
```

#### **12. Replace missing values in Outcome Jurisdiction, Zip Code & Location with NA**
```{r message=FALSE}
df$outcome_jurisdiction[df$outcome_jurisdiction==""] <- NA
df$outcome_zip_code[df$outcome_zip_code==""] <- NA
df$location[df$location==""] <- NA
```

#### **13. Remove the Count column**
```{r message=FALSE}
df <- select(df, -count)
```

#### **14. Export the clean data to csv**
```{r eval=FALSE}
write.csv(df, "C:/Irene/Springboard Study Folder/Capstone Project/Datasets/shelter_clean.csv", row.names = FALSE)
```

