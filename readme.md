## Synopsis

run_analysis is a script to get and cleaning the data from wearables of Samsung Galaxy.

## Code Explanation.

First, it loads all the files you need for the analysis, the train (x and y) and the subject data. All of these files must be contained in the working directory.
Then, it changes the activity number for its name. After that, it gives each dataset a set of field names, to later query them by their name.

Then, for each dataset(train_x and test_x), bind the corresponding activity data. After that, the code finds all the field names that are related to a standard deviation or an average calculation.
Extract then all the columns of the set, giving a total of 68 columns.

Then it uses regex to change all the variable names to convert them to human readable names.

In the end, it writes the resulting data frames to text files.

##Code Dependencies.
The code uses the plyr library. Install it with the following command: install.packages("plyr")

