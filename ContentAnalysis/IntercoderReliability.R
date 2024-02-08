#transposing the data into wide dataset
#coder_id is the row, now each content id is a column, and the target variable is the value
wide_data <- pivot_wider(test_data, id_cols = coder_id, names_from = content_id, values_from = ExVar2)
#removing coder_id column to run Krippendorff's alpha

# Setting up necessary libraries (i.e., tools for testing Krippendorff's alpha)
#Installing them packages if they are not installed:
for (p in c("tidyverse", "irr")) {
  if (!requireNamespace(p)) {
    install.packages(p)
  }
}
# Load the libraries
library(tidyverse)
library(irr)
#Creating data
test_data <-
  tribble(
    ~content_id, ~coder_id, ~ExVar1, ~ExVar2,   ~ExVar3,     #replace the syntax starting from this lane
    1,           "A",       1,     "Red",   FALSE,
    2,           "A",       3,     "Blue",  TRUE,
    3,           "A",       5,     "Blue",  TRUE,
    4,           "A",       7,     "Green", TRUE,
    5,           "A",       1,     "Red",   FALSE,
    1,           "B",       1,     "Red",   FALSE,
    2,           "B",       3,     "Blue",  FALSE,
    3,           "B",       3,     "Green", FALSE,
    4,           "B",       7,     "Green", TRUE,
    5,           "B",       3,     "Red",   FALSE,           #to this lane by paste your data
  )
#extracting a list of variable names in the dataset
dflist <- colnames(test_data)
dflist <- dflist[dflist != 'content_id']
dflist <- dflist[dflist != 'coder_id']

#===========================================================================#

#Copy and paste the below code separately from above
#Recommend running tests for interval and nominal separately as well for legibility
#cycling throuh the list of variables and run Krippendorff's alpha

# Analysis for Interval Data:
for (i in dflist) {
  wide_data <- pivot_wider(test_data, id_cols = coder_id, names_from = content_id, values_from = i)#transposing the data into wide dataset
  wide_data <- select(wide_data, -coder_id)#removing coder_id column to run Krippendorff's alpha
  wide_data <- as.matrix(wide_data)#converting the data into matrix
  Result <- kripp.alpha(wide_data, method = "interval")#running Krippendorff's alpha
  print(i)
  print(Result)
  }

# Analysis for Nominal Data:
for (i in dflist) {
  wide_data <- pivot_wider(test_data, id_cols = coder_id, names_from = content_id, values_from = i)#transposing the data into wide dataset
  wide_data <- select(wide_data, -coder_id)#removing coder_id column to run Krippendorff's alpha
  wide_data <- as.matrix(wide_data)#converting the data into matrix
  Result <- kripp.alpha(wide_data, method = "nominal")#running Krippendorff's alpha
  print(i)
  print(Result)
  }