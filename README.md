# README
Getting and cleaning data
Peer-graded assignment

This readme file describes how the script run_analysis.R works and explains the decisions that were made to create "tidy data." 

1. The script first calls another script, download_unzip.R, which downloads, dates, and unzips the required files. 
2. It checks the dimensions of each data set to ensure that they are correct.
3. It pulls variable names from the features file and stores them. 
4. It pulls the test data from three files, and the training data from three files, and merges them. (Step 1.)
5. It keeps only the variables for subject, activity, mean, and standard deviation. (Step 2.)
6. It gives activities more understandable names. (Step 3.) I chose to eliminate the space in the activity descriptions, with a capital letter denoting two-word descriptions (i.e., "walkingUpstairs" instead of "walking upstairs""). This is to prevent confusion in the text files as a word with a space can look like two variables. 
7. It gives variables descriptive names. (Step 4.) It removes the periods from variable names, and again have a capital letter denote a new word in the variable name.  For example, "tBodyAccMeanX" reads as "t body acc mean x." This increases readability compared to "tbodyaccmeanx."
8. The variable names were largely left as-is because there were a balance of length and descriptiveness. In this case, the variable names were a balance of length and descriptiveness. Variable names that are too long can be cumbersome. The current variable names (e.g. "Acc" means acceleration) present enough information, for someone who is working with the data, to quickly understand the variable.
9. Each row contains one observation: all readings associated with one instance of a person doing an activity. 
10. It creates the tiny data set with the means of all of observations calculated for each subject-activity pair. (Step 5.) 
11. Thanks for reading!