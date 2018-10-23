#README
##Getting and cleaning data
##Peer-graded assignment

This readme file describes how the script run_analysis.R works. 

1. The script first calls another script, download_unzip.R, which downloads and unzips the required files. 
2. It checks the dimensions of each data set to ensure that they are correct.
3. It pulls variable names from the features file and stores them. 
4. It pulls the test data from three files, and the training data from three files, and merges them. 
5. It keeps only the variables for subject, activity, mean, and standard deviation.
6. It gives activities more understandable names. I chose to eliminate the space in the activity descriptions, with a capital letter denoting two-word descriptions (i.e., "walkingUpstairs" instead of "walking upstairs""). This is to prevent confusion in the text files as a word with a space can look like two variables. 
7. It removes the periods from variable names, and again have a capital letter denote a new word in the variable name. For example, "tBodyAccMeanX" reads as "t body acc mean x." 
8. The variable names were largely left as-is because there were a balance of length and describptiveness. In this case, I believe the variable names were a balance of length and descriptiveness. Variable names that are too long can be cumbersome. 
