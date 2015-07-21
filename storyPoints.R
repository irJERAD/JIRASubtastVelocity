## Take excel file from JIRA
## Extract Story Points from "Summary" Column

# Assuming story points are the last number in the "Summary" column,
# Regex expression [0-9]*$ will work
# [0-9]*$ will grab any single string of digits that ends the line
# [0-9] = numeric
# * = grab as many as you can before a space
# $ = ends line

storyPoints <- function(path){
  # load CSV file into memory
  data <- read.csv(path)
  
  # remove top two space rows
  data <- data[c(3:dim(data)[1]), ]
  # this leaves row one as the header / column names
  
  # turn first row into header / column names
  colnames(data) <- unlist(data[1,])
  # remove first - repeat of header / col names
  data <- data[-1,]
}