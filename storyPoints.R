## Take excel file from JIRA
## Extract Story Points from "Summary" Column

# Assuming story points are the last number in the "Summary" column,
# Regex expression [0-9]*$ will work
# [0-9]*$ will grab any single string of digits that ends the line
# [0-9] = numeric
# * = grab as many as you can before a space
# $ = ends line

### Temp Path: /Users/jerad/Documents/Rcode/JIRASubtastVelocity/sprint1.csv

storyPoints <- function(path){
  ## Libraries
  # stringr for extracting numbers from summary
  # library('stringr')
  
  # load CSV file into memory
  data <- read.csv(path)
  
  # remove top two space rows
  data <- data[c(3:dim(data)[1]), ]
  # this leaves row one as the header / column names
  
  # turn first row into header / column names
  colnames(data) <- unlist(data[1,])
  # remove first - repeat of header / col names
  data <- data[-1,]
  
  # iterate through summary column to extract story points into new variable / column
  for (i in data$Summary) {
    data$storyPoints <- extract(i)
  }
  
}


extract <- function(summary){
  ## Extract Story Points from Summary
  # [0-9]+$ = regex for last number with length > 0
  # gsub('[0-9]+$','\\1',i) = extracts the entire string not matching [0-9]+$ pattern
  # substr() takes out everything from the original string except what we want
  
  # coerce factor variable to character vector
  summary <- as.character(summary)
  pattern <- '[0-9]+$'
  # create the inverse of the desired string characters
  inverseString <- gsub(pattern, '\\1', summary)
  # subset original string by removing the inverseString from it
  string <- substr(summary, nchar(inverseString), nchar(summary))
  
  # coerse desired characters from string into numeric for column input
  num <- as.numeric(string)
  return(num)
}