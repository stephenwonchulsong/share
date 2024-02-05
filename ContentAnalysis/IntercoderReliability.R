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
#Creat/add data
test_data <-
  tribble(
    ~content_id, ~coder_id, ~ExVar1, ~ExVar2,   ~ExVar3,
    1,           "A",       1,     "Red",   FALSE,
    2,           "A",       3,     "Blue",  TRUE,
    3,           "A",       5,     "Blue",  TRUE,
    4,           "A",       7,     "Green", TRUE,
    5,           "A",       1,     "Red",   FALSE,
    1,           "B",       1,     "Red",   FALSE,
    2,           "B",       3,     "Blue",  FALSE,
    3,           "B",       3,     "Green", FALSE,
    4,           "B",       7,     "Green", TRUE,
    5,           "B",       3,     "Red",   FALSE,
  )
#transposing the data into wide dataset
#coder_id is the row, now each content id is a column, and the target variable is the value
wide_data <- pivot_wider(test_data, id_cols = coder_id, names_from = content_id, values_from = ExVar2)
#removing coder_id column to run Krippendorff's alpha
wide_data <- select(wide_data, -coder_id)
wide_data <- as.matrix(wide_data)
func1 <- function (ExVar2, name=deparse(substitute(ExVar2))) {
    name
}
func1(ExVar2)
kripp.alpha(wide_data, method = "ordinal")
write.csv(wide_data,"wide_data.csv")