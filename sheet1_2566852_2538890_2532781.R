### Stats with R Exercise sheet 1 

## This exercise sheet contains the exercises that you will need to complete and 
## submit by 23:55 on Monday, November 4. Write the code below the questions. 
## If you need to provide a written answer, comment this out using a hashtag (#). 
## Submit your homework via moodle.
## You are required to work together in groups of three students, but everybody 
## needs to submit the group version of the homework via moodle individually.
## You need to provide a serious attempt at solving each exercise in order to have
## the assignment graded as complete. 

## Please write below your (and your teammates') name and matriculation number. 
## Name: Kopf-Giammanco, Martin and Maike Puhl, and Jonathan Watkins
## Matriculation number: 2566852 (MKG), 2538890 (MP), 2532781 (JW)

## Change the name of the file by adding your matriculation numbers
## (sheet01_firstID_secondID_thirdID.R) sheet1_2566852_2538890_2532781



## Many of the things on this exercise sheet have not been discussed in class. 
## The answers will therefore not be on  the slides. You are expected to find 
## the answers using the help function in R, in the textbooks and online. If you 
## get stuck on these exercises, remember: Google is your friend.
## If you have any questions, you can ask these during the tutorial, or use the 
## moodle discussion board for the course.

###############
### Exercise 1: Getting started
###############
## a) Look at your current working directory.
cwd <- getwd()
cwd

## b) Get help with this function.
help(getwd)

## c) Change your working directory to another directory.
setwd("..")
setwd(cwd)

###############
### Exercise 2: Participants' age & boxplots
###############
## In this exercise, we will deal with data from a package.

## a) Install the package "languageR" and load it.
install.packages("languageR")
install.packages("dplyr")
library(languageR)
library(dplyr)
search()

## b) Specifically, we will deal with the dataset 'dutchSpeakersDistMeta'. 
##    This dataset should be available to you once you've loaded languageR.
##    The dataset contains information on the speakers included in the Spoken 
##    Dutch Corpus. Inspect 'dutchSpeakersDistMeta'. Look at the head, tail, 
##    and summary. What do head and tail show you?

head(dutchSpeakersDistMeta) # shows me the first six observations of the dataframe, i.e.
                            # the observations are in rows and the variables are the
                            # columns -- just like in the dataframe.

tail(dutchSpeakersDistMeta) # shows me the last six observations of the dataframe, i.e.
                            # like head() but for the 'bottom' of the dataframe.

summary(dutchSpeakersDistMeta)

## c) Each line in this file provides information on a single speaker. How many 
##    speakers are included in this dataset? In other words, use a function to 
##    retrieve the number of rows for this dataset.
glimpse(dutchSpeakersDistMeta)
# str(dutchSpeakersDistMeta)

## d) Let's say we're interested in the age of the speakers included in the 
##    corpus, to see whether males and females are distributed equally. 
##    Create a boxplot for Sex and AgeYear.

# table(dutchSpeakersDistMeta$Sex)
help(boxplot)
# class(dutchSpeakersDistMeta$AgeYear)
# class(dutchSpeakersDistMeta$Sex)
boxplot(AgeYear ~ Sex, data = dutchSpeakersDistMeta)

## e) Does it seem as if either of the two groups has more variability in age?
# Yes, it seems the group 'female' has more variability. Its ages are
# more spread out. The group 'male' seems to be more compact.

## f) Do you see any outliers in either of the two groups?
# Yes, group 'male' has two outliers.

## g) Now calculate the mean and standard deviation of the AgeYear per group. 
##    Do this by creating a subset for each group.
##    Do the groups seem to differ much in age?

## make subset of observations for group 'male'
males <- dutchSpeakersDistMeta %>%
  filter(Sex == "male")

# calculate mean and standard deviation for subset 'males'
av_age_males <- mean(males$AgeYear)
sd_age_males <- sd(males$AgeYear)

## make subset of observations for group 'female'
females <- dutchSpeakersDistMeta %>%
  filter(Sex == "female")

# calculate mean and standard deviation for subset 'females'
av_age_females <- mean(females$AgeYear)
sd_age_females <- sd(females$AgeYear)

# The two groups 'male' and 'female' differ minimally with respect to average age with the mean for females
# being a bit lower. The above mentioned variability is reflected in the respective standard deviations, with
# 'female'-group's standard deviation being over a year higher than the 'male'-group's sd.

## h) What do the whiskers of a boxplot mean?

# The whiskers extend as far as to include the most extreme
# data points inside 1.5 times the Inter-Quartile-Range (IQR).

# iqr_males <- 1.5*IQR(males$AgeYear)
# iqr_females <- 1.5*IQR(females$AgeYear)

###############
### Exercise 3: Children's stories & dataframes
###############
# A researcher is interested in the way children tell stories. More specifically,
# she wants to know how often children use 'and then'. She asks 25 children to
# tell her a story, and counts the number of times they use 'and then'.
# The data follow:

# 18 15 22 19 18 17 18 20 17 12 16 16 17 21 25 18 20 21 20 20 15 18 17 19 20 

## a) What measurement scale is this data? Is it discrete or continuous? Explain
##    in one sentence why? (remember, comment out written answers)
# The data is numerical and discrete because it is count data (theoretically on an open scale)
# and it is based on whole numbers, i.e. you can't count half an occurrence of 'and then' or 0.42, resulting.

## b) In the next questions (c-e), you will create a dataframe of this data, 
##    which will also include participant IDs.
##    Why is a dataframe better suited to store this data than a matrix?
# In a dataframe not all the data needs to be of the same type
# which is the core criterion for matrices.

## c) First create a vector with participant IDs. Your vector should be named 
##    'pps', and your participants should be labeled from 1 to 25
pps <- c(1:25)

## d) Next, create a vector containing all the observations. Name this vector 'obs'.
obs <- c(18, 15, 22, 19, 18, 17, 18, 20, 17, 12, 16, 16, 17, 21, 25, 18, 20, 21, 20, 20, 15, 18, 17, 19, 20)

## e) Create a dataframe for this data. Assign this to 'stories'. 
stories <- data.frame(pps, obs)
glimpse(stories)
## f) Take a look at the summary of your dataframe, and at the classes of your 
##    columns. What class is the variable 'pps'?
class(stories$pps)
# integer

## g) Change the class of 'pps' to factor. Why is factor a better class for this
##    variable?
stories$pps <- factor(stories$pps)
class(stories$pps)
# class of pps is factor
# A factor is a better class for pps since we do not want to calculate with its numerical values.

## h) Plot a histogram (using hist()) for these data. Set the number of breaks 
##    to 8.

h <- hist(x = stories$obs, breaks = 8, main="Histogram - Stories", xlab="Observations")

## i) Create a kernel density plot using density().
d <- density(stories$obs)
plot(density(stories$obs), main="Kernel Density Plot - Stories", xlab="Observations")

## j) What is the difference between a histogram and a kernel density plot?

# A histogram shows bars representing the frequencies of (a range of) observations, i.e. one
# observation more with a certain value will increase the bar for that value by one.
# A kernel density plot assumes a normal distribution for every singly data point and stacks
# the areas under the curves for all data points on top of each other.

## This is a difficult one, remember you just need to provide a serious attempt at solving each 
## exercise in order to pass. 
## k) Overlay the histogram with the kernel density plot 
##    (hint: the area under the curve should be equal for overlaying the graphs 
##    correctly.)

# Not sure if this is what you wanted to see. This is the closest I could figure out:
bin <- 17

x_dens <- unlist(d[1], use.names=FALSE)
y_dens <- unlist(d[2], use.names=FALSE)
y_dens <- y_dens * (length(y_dens) / bin)

hist(x = stories$obs, breaks = bin, main="Stories - Histogram with Kernel Density", xlab="Observations")
lines(x_dens, y_dens, col="blue", lwd=2)

###############
### Exercise 4: Normal distributions
###############
## In this exercise, we will plot normal distributions.

## a) First, use seq() (?seq) to select the x-values to plot the range for
##    (will become the x-axis in the plot).
##    Get R to generate the range from -5 to 5, by 0.1. Assign this to the 
##    variable x.
x <- seq(-5, 5, 0.1)

## b) Now we need to obtain the y-values of the plot (the density). We do this 
##    using the density function for the normal distribution. 
##    Use "help(dnorm)" to find out about the standard functions for the normal 
##    distribution.

# help(dnorm)
y <- dnorm(x)

## c) Now use plot() to plot the normal distribution for z values of "x". 
plot(x, y)#, type="l", col="blue", lwd=2)

## d) The plot now has a relatively short y-range, and it contains circles 
##    instead of a line. 
##    Using plot(), specify the y axis to range from 0 to 0.8, and plot a line 
##    instead of the circles.
plot(x, y, type="l", col="blue", lwd=2, ylim=c(0, 0.8))


## e) We want to have a vertical line to represent the mean of our distribution.
##    'abline()' can do this for us. Look up help for abline(). 
##    Use abline() to create the vertical line. Specify the median of x using
##    the argument 'v'.
##    In order to get a dashed line, set the argument 'lty' to 2.
# help(abline)

plot(x, y, type="l", col="blue", lwd=2, ylim=c(0, 0.8))
abline(v=mean(x))

plot(x, y, type="l", col="blue", lwd=2, ylim=c(0, 0.8))
abline(v=mean(x), lty=2)

## f) Take a look at the beaver1 dataset. (You can see it by typing "beaver1".) 
##    Then select only the temperature part and store it in a variable "b1temp".
b1temp <- beaver1$temp

## g) Calculate the mean and standard deviation of this dataset and plot a normal
##    distribution with these parameters.
b1_mn <- mean(b1temp)
b1_sd <- sd(b1temp)
dens_b1_temp <- dnorm(b1temp, b1_mn, b1_sd)

plot(b1temp, dens_b1_temp, col="blue")

## h) We observe two temparatures (36.91 and 38.13). What's the likelihood that
##    these temperatures (or more extreme ones) respectively come 
##    from the normal distribution from g)?
qqplot(b1temp, dens_b1_temp)
qqplot(dens_b1_temp, b1temp)

(a <- (95 - b1_mn) / b1_sd)
(a <- 1 - pnorm((95 - b1_mn) / b1_sd))
(b <- 1 - pnorm((95 - 81.3) / 11.3))

## i) Use the random sampling function in R to generate 20 random samples from
##    the normal distribution from g), and draw a histogram based on this sample.
##    Repeat 5 times. What do you observe?
samp_1 <- sample(b1temp, 20)
samp_2 <- sample(b1temp, 20)
samp_3 <- sample(b1temp, 20)
samp_4 <- sample(b1temp, 20)
samp_5 <- sample(b1temp, 20)

hist(x = samp_1, main="Beaver 1 - Sample of 20", breaks = 8, xlab="Measurements")
hist(x = samp_2, main="Beaver 1 - Sample of 20", breaks = 8, xlab="Measurements")
hist(x = samp_3, main="Beaver 1 - Sample of 20", breaks = 8, xlab="Measurements")
hist(x = samp_4, main="Beaver 1 - Sample of 20", breaks = 8, xlab="Measurements")
hist(x = samp_5, main="Beaver 1 - Sample of 20", breaks = 8, xlab="Measurements")

# It seems that the samples are distributed kind of normally.
# At least, they fit 'into' or 'within' the curve of a normal distribution.
# Most of the time.

