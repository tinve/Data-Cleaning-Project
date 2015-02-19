# Data-Cleaning-Project
Course project for Coursera Getting and Cleaning Data course

Download **getdata-projectfiles-UCI HAR Dataset.zip** file with data from the accelerometers of the Samsung Galaxy S smartphone. Extract it directly into your R working directory. You should see **UCI HAR Dataset** directory now.

Run the script. It will group measurements by subject (1 to 30) and activity (walking, walking_upstairs, walking_downstairs, sitting, standing and lying), pick values with "mean()" and "std()" in their names and calculate
average for each group. Then it will write the result to a file **tidy_data.txt** in **UCI HAR Dataset directory**.
Read CodeBook file for the details of output file format.

Read script comments to learn how to modify the script to include more values (with "Mean" in their names).
