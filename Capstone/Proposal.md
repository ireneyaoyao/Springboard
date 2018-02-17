<center> <h1> Animal Shelter Adoption Prediction Proposal</h1> </center>
<center> <h4> Irene Yao </h4> </center>
<center> <h4> February 14, 2018 </h4> </center>

### **Introduction**

According to ASPCA, approximately 6.5 million companion animals enter U.S. animal shelters nationwide every year. Among those animals, approximately 1.5 million are euthanized for different reasons. Animal rescue centers are currently facing challenges such as overpopulation, unbalanced distribution and insufficent funding support. I hope this analysis could provide insights into the factors and characteristics of the animals that affect the adoption rate and help rescue centers to predict the probability of adoption and make best use of their resources for the desirable outcome.  

### **Data Source** 
For this analysis, I will use the [animal intake and outcome dataset](https://data.sonomacounty.ca.gov/Government/Animal-Shelter-Intake-and-Outcome/924a-vesw/data) found on Sonoma County website. The data can be downloaded as a .csv file for further cleanup and data wrangling.   

Variables included in the dataset: animal type, breed, size, sex, age, days in the shelter, location, etc. 
    
### **Data Analysis Approaches (Draft)**
* Fill in missing values in the size column based on DOB and breed
* Create a new sex column to transform Spayed/Neutered into Female/Male

### **Questions to Answer**
* Has turnaround improved over time (i.e. have animals stayed for a shorter time in the rescue center?)
* Do factors such as species, age, intake condition affect the adoption rate?
* Do cities have different preference on animal types?
* Is there a difference between cat and dog adoption situation? 
* Do people adopt/give away more pets during certain time of the year? 
