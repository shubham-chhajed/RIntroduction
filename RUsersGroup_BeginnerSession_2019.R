# "Macquarie R Users Group - An Introduction to R 

## Section 1

# Note: everything after # is considered a comment (simple notes), NOT code.

### Goals

# 1. Getting comfortable with R Studio Interface and finding out what it is at all.
# 2. Using basic commands.
# 3. Loading and saving data.
# 4. Basic statistics.
# 5. Plotting.
# 6. Not being scared of coding!


# 1. We can assign (<-) a basic calculation to the object 'a' and call the content of 'a'. Execute your code using Ctrl+Enter

a <- 1+2 # here R works ike a calculator
a        # print a to see what it contains


# 2. We Use function c() to combine specific values into a vector. Assign this new vector to object 'x'.

x <- c(1,2,3,4) # 'c' is a function that combines values into the vector x (object), the numbers are arguments

# A vector is a sequence of data #components# of the same basic type (i.e. numbers or letters)


# 3. Using function mean (), we can extract the mean of our vector. 

mean(x) # mean() is a function


# 4. Create two vectors (they are going to be numeric in our case) using seq() and assign them the object seq_a and seq_b. object seq_a contains a vector with the components 1 to 10 and is increasing by 1. seq_b contains the components 1 to 25 and increases by 2. If you are not sure how to use a function, such as seq(), just call ?seq and have a look what arguments can be used. 

seq_a <- seq(from=1,to=10,by=1)
seq_b <- seq(from=1,to=25,by=2)

# 5. Using cbind() you can bind two vectors to create a #matrix# (a kind of table). Use cbind() to bind seq_a and seq_b. Assign it to the object 'c'. For help, call ?cbind

c <- cbind(seq_a,seq_b)

# 6. Oops! Let's see what went wrong. Can you decipher the error message? Have a look at seq_a and seq_b. Just type seq_a and seq_b and execute both. No worries, debugging (resolving errors) is a major part of programming.

seq_a
seq_b

# 7. To make the problem more obvious, let's check the length of each object. Use length().

length(seq_a)
length(seq_b)

# 8. To cbind() two vectors they have to have the same length. Let's overwrite seq_a and create a vector of the same length as seq_b. Check if the length is matching the other vector and bind them using cbind(). Assign this object to a new object, 'c'. What class has 'c'? Check it!

seq_a<- seq(1,13,by=1)
length(seq_a)
c <- cbind(seq_a,seq_b)
class(c) 
# class() can figure out if you are working with vectors, matrices, dataframes, lists etc....it can do more but this is all we need for now.

#Note: The counterpart to cbind() is rbind() if you would like to connect rows instead of columns.

# 9. Plot 'c' by using plot()

plot(c)

# Note: If we wanted to, we could modify the appearance of this plot completely. Labelling axis, change tickmarks and intervals, add text or shapes...more #than you can think of now. With just a few lines of code we can create beautiful plots. Once a plot is coded we can use it over and over again and also easily #modify it. See here:##

pairs(iris[1:4], main = "Edgar Anderson's Iris Data", pch = 21, bg = c("red","green3","blue")[unclass(iris$Species)])

### What we have learned:

# Get an idea of what R can possibly do
# Discover R Studio
# Become familiar with some basic expressions
# Encounter error messages
# Create some first data
# Have an idea that there are different classes that R can use (different packages want different classes)
# See what a basic plot looks like and how it could look like (Know that there are different ways/ packages of plotting something)


## Section 2

# Note: everything after # is considered a comment (simple notes), NOT code.

### Goals

# 1. Getting comfortable with R Studio Interface and finding out what it is at all.
# 2. Using basic commands.
# 3. Loading and saving data.
# 4. Basic statistics.
# 5. Plotting.
# 6. Not being scared of coding!


# Create a new project folder for our R users introduction course: R project > New project > New directory > Browse and name it: 'My first R project'.
# Create 3 subfolders within the project and name them 'Input', 'Output' and 'Scripts' 
# Move our data to input folder
# Create new script: File > New File > R script
# Start coding

1. Let's import our data and see what it looks like

# if the dataset is build in R, it is unnecessary to export it as csv and import it, you just need the following function data()
# it is the case with iris and PlantGrowth datasets, so they can be loaded using:
data(iris)
data(PlantGrowth)

# or

irisdata <- read.csv("Input/irisdata.csv") 
irisdata
# Why using .csv instead of Excel sheets (.xls and .xlsx)?

2. We can easily call some summary stats now.

summary(irisdata)

3. We can also access specific values in this dataset. For vectors, matrices and dataframes we can use "[]", and the "$" is useful only for dataframes. If we use "[]" then we must think of it like this: [rows,columns]

irisdata[,1] # all values in column 1

irisdata[1,1] # value at row 1, column 1


irisdata[,1:3] # all values in columns 1 to 3


irisdata['Species'] # all values in column with column name 'Species'


irisdata$Sepal.Length # all values in column with column name 'Sepal.length'

as.matrix(irisdata)$Sepal.Length # this won't work. atomic vectors = (logical, integer, double (sometimes called numeric), and character)

irisdata[1, 1:7] # first row only of values in columns 1 to 7

dim(irisdata) #shows dimensions 


4. If we make any changes to our data, we can save our new data in a spreadsheet.

write.csv(irisdata, 'New irisdata.csv', row.names=FALSE) # Why am I using row.names=FALSE?
write.csv(irisdata, 'New irisdata incl rownames.csv')


##Nice! We have learned a lot about manipulating data so far! Use R cheat sheets (just google R cheatsheets) to look up all those functions over and over again!##


### Last part! Our first data analysis!

# 1. Read in a new dataset in csv 

plant.df <- read.csv("Input/PlantGrowth.csv") 


# 2. Clean the data up a bit and specify that the group is a factor variable.

plant.df$group <- factor(plant.df$group,
  labels = c("Control", "Treatment 1", "Treatment 2"))

# 3. Visualise our data with a boxplot. 

boxplot(weight~group, plant.df)


# 4. Create a folder to store the results. 

# this line can be different for Mac users
dir.create("output")

# And save it as a .pdf file in the output folder.

pdf('output/My Boxplot.pdf', width = 20, height = 10 , paper = 'a4r')
boxplot(weight~group, plant.df, ylab='Dried weight of plants [g]')
dev.off() # close window to finish saving


# 4. Start statistical analysis. This is a simple linear model with an ANOVA. 

plant.mod1 = lm(weight ~ group, data = plant.df) 
# we're using lm() to create a pretty different object called a list, which has lots of data in it, organised in a defined structure.

summary(plant.mod1) # summary() extracts some of this data and prints it out neatly for us

anova(plant.mod1)


# 5. There are hundreds of packages in R that have ready functions for us to use. All you need to do is look up which package you need, install it and load it into R. 
# In our case, as we ran a linear model, we probably want to visualise our model estimates instead of just using a boxplot. Let us install and load a new package that allows to easily do this. 


# function to use an improved read.csv function
#install.packages('readr') #install
library(readr) #load

# Now all we have to do is use a function within the newly loaded package!

irisdata <- read_csv("Input/irisdata.csv") 
irisdata


## More Information

# Resources to learn R coding##
        # Book A Beginner's Guide to R (Use R!) - Alain Zuur, Elena Ieno and Eric Meesters
        # Package ([Swirl](http://swirlstats.com/))
        
# Resources to learn plotting with R Base Graphics##
        # R Graph Cookbook - Hrishi V. Mittal
        
# Resources to learn plotting with ggplot2##
        # ggplot2 (Use R!) - Hadley Wickham
        
# Resources to learn data manipulation in R##
        # Data manipulation with R (Use R!) - Phil Spector
        
# Resources to learn stats in R##
        # Introductory statistics with R (Use R!) - Peter Dalgaard
        
## What we have learned

# Get familiar with R Studio and the differences to R
# How to import and export data in R?
# What do projects and setwd() have in common and what is its purpose?
# How to manipulate data?
# Your first data analysis
# How to proceed on your own
