#Load the data in RStudio
df <- read.csv("C:/Irene/Springboard Study Folder/refine_original.csv")

#Clean up brand names: change all company names to lowercase; removed all spaces and spelling mistakes. 
library(tidyr)
library(dplyr)
library(stringr)

df$company <- tolower(df$company)
ph_index<-which(str_detect(df$company, "ps"))
df$company[ph_index]<-"philips"
akzo_index<-which(str_detect(df$company, "ak"))
df$company[akzo_index]<-"akzo"
van_index<-which(str_detect(df$company, "van"))
df$company[van_index]<-"van houten"
uni_index<-which(str_detect(df$company, "uni"))
df$company[uni_index]<-"unilever"

#Separate product code and number
df2 <- separate(df, Product.code...number, c("product_code", "product_number"))

#Add product categories
x <- factor(df2$product_code)
levels(x) <- c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")

df3 <- df2 %>% 
  mutate(product_category = x) %>% 
  select(-product_code)

#Add full address for geocoding, combined address, city & country
df4 <- unite(df3, full_address, c("address", "city", "country"), sep=",")

#Create dummy variables for company and product category
df5 <- df4 %>% 
  mutate(company_philips = as.numeric(company=="philips")) %>% 
  mutate(company_akzo = as.numeric(company=="akzo")) %>% 
  mutate(company_van_houten = as.numeric(company=="van houten")) %>% 
  mutate(company_unilever = as.numeric(company=="unilever")) %>% 
  mutate(product_smartphone = as.numeric(product_category=="Smartphone")) %>% 
  mutate(product_tv = as.numeric(product_category=="TV")) %>% 
  mutate(product_laptop = as.numeric(product_category=="Laptop")) %>% 
  mutate(product_tablet = as.numeric(product_category=="Tablet"))

#Save the final output as refine_clean.csv
write.csv(df5, file = "C:/Irene/Springboard Study Folder/refine_clean.csv", row.names = FALSE)
