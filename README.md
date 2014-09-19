<h1> README for the mergedsubset.txt and tidydata.txt</h1>

<p> 
This document explains how all of the scripts work and how they are connected for the project assignment related to the Getting and Cleaning Data course. </p>


<ul> 
<li> Create a folder called 'mainproject'. </li>
<li> Download this zip file and extract it into the 'mainproject' folder. This should create a folder called 'UCI HAR Dataset' within the 'mainproject' folder. <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a></li>
<li> Read the CodeBook.md for a brief description of the data and how it has been transformed. </li>
<li> Copy the file run_analysis.R into the 'mainproject' folder. </li>
<li> Install the reshape2 package into R. </li>
<li> Set the working directory in R to point to the mainproject folder. For example in windows: setwd("C://mainproject").</li>
<li> Type source("run_analysis.R") to run the file. </li>
<li> Open the 'mainproject' folder. The script will create 2 tab separated text files: mergedsubset.txt and tidydata.txt (see CodeBook.md for details).</li> 
</ul>

