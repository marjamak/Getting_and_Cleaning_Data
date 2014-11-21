Getting_and_Cleaning_Data
=========================

Repository for "Getting and Cleaning Data" course


=====================================================================


Running the run_analysis.R:
===========================

Preconditions

There is "UCI HAR Dataset" directory in the working directory.


Steps:

1. Download run_analysis.R from GitHub to the working directory.

2. Start R console
 
3. Set working directory if needed with command:
   > setwd("<working directory>")

4. Execute "run_analysis.R" script with command:
   > source("run_analysis.R")

Note: "plyr" package need to be installed-


Postconditions:

TidyDataSet.txt file is in the working directory.

> dim (tidy_data)
[1] 180  88
>



The TidyDataSet.txt content:
============================

The TidyDataSet contains 88 columns

- The first column is "Subject" that defines subject who did action.
There are Subject_01..Subject_30	

- The last column is ActivityLabel that defines activity.
There are six possible Activity values:
"WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"

- The rest columns are mean values about different measurements of the subject. They are described in Codebook_tidy.txt and features_tidy.txt.

There are 180 rows of measurements, row per each Activity per each subject. 



