  #Load the data in RStudio
df <- read.csv("C:/Irene/Springboard Study Folder/Exercises/refine_original.csv")

#Clean up brand names: change all company names to lowercase; removed all spaces and spelling mistakes. 
library(tidyr)
library(dplyr)
library(stringr)

df$company <- tolower(df$company)
df1 <- df %>% 
  mutate(company=ifelse(grepl("ps", company), "philips",
                        ifelse(grepl("ak", company), "akzo", 
                               ifelse(grepl("van", company), "van houten", "unilever"))))

#Separate product code and number
df2 <- separate(df1, Product.code...number, c("product_code", "product_number"))

#Add product categories

df3 <- df2 %>% 
  mutate(product_code = ifelse(product_code=="p", "Smartphone", 
                               ifelse(product_code=="v", "TV", 
                                      ifelse(product_code=="x", "Laptop", "Tablet"))))
                               

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
