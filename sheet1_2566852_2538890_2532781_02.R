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
## (sheet01_firstID_secondID_thirdID.R)



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

getwd()
(cwd <- getwd())
#@Martin: warum hast du das hier in klammern?
#@Martin: ich hab nur getwd auch gelassen, weil das die eigentliche Aufgabe ist
#@Maike: Die Klammern drucken das Ergnis von get() in die Konsole, was nicht passieren würde,
# wenn ich es nur der Variable cwd zuweise. Somit errreiche ich die eigentliche Aufgabe und habs
# zusätzlich einer Variable zugewiesen, die ich unten brauche beim letzten setwd().

## b) Get help with this function.

help(getwd)

## c) Change your working directory to another directory.

setwd("..")
setwd(cwd)
#@Martin: find ich gut. Geht die ja nix an wo's gespeichert ist
#und mit absolutem Pfad wirds schwierig.

###############
### Exercise 2: Participants' age & boxplots
###############
## In this exercise, we will deal with data from a package.

## a) Install the package "languageR" and load it.

install.packages("languageR")
library(languageR)
#@Martin: ich hab library(dplyr) hier raus genommen, weil wir das erst später brauchen
#@Maike: Ist OK, ich wollte für mich nur dplyr haben, weil ich später glipmse verwende.


## b) Specifically, we will deal with the dataset 'dutchSpeakersDistMeta'.
##    This dataset should be available to you once you've loaded languageR.
##    The dataset contains information on the speakers included in the Spoken
##    Dutch Corpus. Inspect 'dutchSpeakersDistMeta'. Look at the head, tail,
##    and summary. What do head and tail show you?

head(dutchSpeakersDistMeta)
#Head shows the first 6 observations of the dataframe
#(the observations are in rows and the variables are the columns -- just like in the dataframe)

tail(dutchSpeakersDistMeta)
#Tail shows the last 6 observations of the dataframe.

summary(dutchSpeakersDistMeta)

#@Martin: hier hab ich unsere beiden kombiniert.
#@Maike: Roger.

## c) Each line in this file provides information on a single speaker. How many
##    speakers are included in this dataset? In other words, use a function to
##    retrieve the number of rows for this dataset.

dim(dutchSpeakersDistMeta)
# 165 speakers (observations) and 6 variables

#@Martin: hier hast du glimpse() aber das zeigt das nicht so schön wie dim().
#Ich würd dim lassen.
#@Maike: Roger.

## d) Let's say we're interested in the age of the speakers included in the
##    corpus, to see whether males and females are distributed equally.
##    Create a boxplot for Sex and AgeYear.

#@Martin: das hier hab ich.
boxplot(dutchSpeakersDistMeta$AgeYear~dutchSpeakersDistMeta$Sex,
        xlab = "Sex",
        ylab = "Year of Birth")

#@Martin: das hier hast du.
# table(dutchSpeakersDistMeta$Sex)
help(boxplot)
# class(dutchSpeakersDistMeta$AgeYear)
# class(dutchSpeakersDistMeta$Sex)
boxplot(AgeYear ~ Sex, data = dutchSpeakersDistMeta)

#@Martin: ist denk ich egal. Ich hab die Achsen hässlich beschriftet,
#du hast den dataframe extra angegeben. Mir egal, welches wir nehmen.

#@Maike: Dann schlag ich 'ne Kombination mit  kleinen Tweaks vor:
boxplot(AgeYear ~ Sex, data = dutchSpeakersDistMeta,
        xlab = "Sex",
        ylab = "Year of Birth")


## e) Does it seem as if either of the two groups has more variability in age?

#'Female' seems to have more variablity. Its ages are
# more spread out. The group 'male' seems to be more compact.

#@Martin: du schreibst mehr irgendwie. hab das dazu genommen.

## f) Do you see any outliers in either of the two groups?

#There are two outliers in 'male'.

## g) Now calculate the mean and standard deviation of the AgeYear per group.
##    Do this by creating a subset for each group.
##    Do the groups seem to differ much in age?

#@Martin: hier wär dann dplyr. Ich hab deine Erklärungen dazu genommen.
#sind dir die assignments mit <- wichtig oder können wir = lassen?
#warum hast du sd und av jeweils variablen zugewiesen?

#@Maike: Ich wollte dplyr oben laden, weil das good practice ist generell bei Coden.
# Die Assignments mit ' <- ' sind bei R üblich für Variablen. '=' funkt auch, aber
# für R scheint ' <- ' good practice zu sein bei variable assigment. Wir können '='
# lassen Weisswurscht is.
library(dplyr)

## make subset of observations for group 'male
males = dutchSpeakersDistMeta %>%
  filter(Sex == 'male')

## make subset of observations for group 'female
females = dutchSpeakersDistMeta %>%
  filter(Sex == 'female')

#@Martin: du hast hier jeweils mit av_age_males <-, etc. brauchen wir nicht oder?
#@Maike: Nicht unbedingt. Ich weise Sachen gern Variablen zu.
mean(males$AgeYear)
sd(males$AgeYear)

mean(females$AgeYear)
sd(females$AgeYear)

#@Martin: du schreibst mehr, aber ich hab sie kombiniert hier.

# The two groups 'male' and 'female' differ minimally with respect to average age with the mean for females
# being a bit lower, so the females are a bit older on average.
#The above mentioned variability is reflected in the respective standard deviations, with
# 'female'-group's standard deviation being over a year higher than the 'male'-group's sd


## h) What do the whiskers of a boxplot mean?

#@Martin: kombi wie oben.
#@Maike: Roger.
#Whiskers show the most extreme data points within 1.5 times the Inter-Quartile-Range (IQR).

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

#@Martin: du hast hier dass die Daten count data und an open scale sind.
#Das stimmt so nicht mein ich, also geht um die Skala. Mein Vorschlag:
#@Maike: Roger.

#The data is ratio-scaled and discrete. It is discrete because we know every value and cannot
#have e.g. half values (you cannot use 'and then' 1.5 times) and it is ratio-scaled because
#the difference between the steps is equidistant, mathematical operations make sense, and there is
#a natural zero (if a child uses no 'and then').

## b) In the next questions (c-e), you will create a dataframe of this data,
##    which will also include participant IDs.
##    Why is a dataframe better suited to store this data than a matrix?

#@Martin: Wir haben unterschiedliche Gründe:

#hier ist dein Grund
# In a dataframe not all the data needs to be of the same type
# which is the core criterion for matrices.

#hier ist mein Grund.
#Because we can name variables (and observations) in dataframe but not in a matrix.

#@Martin: Kombi?
#Because in a dataframe not all the data needs to be of the same type
# which is the core criterion for matrices and because we can name variables
#(and observations) in dataframe but not in a matrix.
#@Maike: Roger.

## c) First create a vector with participant IDs. Your vector should be named
##    'pps', and your participants should be labeled from 1 to 25

#@Martin: ich habs mit seq gemacht und du mit c. Welches nehmen wir?
pps <- seq(1:25)
pps <- c(1:25)
# ist in dem Fall egal. c() ist standard für vectors. 

## d) Next, create a vector containing all the observations. Name this vector 'obs'.

obs <- c(18, 15, 22, 19, 18, 17, 18, 20, 17, 12, 16, 16, 17, 21, 25, 18, 20, 21, 20, 20, 15, 18, 17, 19, 20)


## e) Create a dataframe for this data. Assign this to 'stories'.

stories <- data.frame(pps, obs)


## f) Take a look at the summary of your dataframe, and at the classes of your
##    columns. What class is the variable 'pps'?

#@Martin: du hast glimpse() statt summary(). Ich denk summary() passt gut,
#wenn sie "take a look at the summary" schreiben
#@Maike: passt

summary(stories)
class(stories$pps)
#class of pps is integer.

## g) Change the class of 'pps' to factor. Why is factor a better class for this
##    variable?

#@Martin: hab hier die Erklärung wieder kombiniert
#@Maike: passt

stories$pps <- factor(stories$pps)
# A factor is a better class for pps because this is the ID of the participant i.e. their 'name' and not a numeric value.

## h) Plot a histogram (using hist()) for these data. Set the number of breaks
##    to 8.
#@Martin: hier hab ich deins genommen, weil du's noch benannt hast und so.

h <- hist(stories$obs, breaks = 8, main="Histogram - Stories", xlab="Observations")


## i) Create a kernel density plot using density().

#@Martin: hier hab ich deins genommen mit einer änderung:
#du hattest statt d im plot Density(stories$obs) stehen, aber wenn wirs vorher
#zu d assigned haben können wir das auch nehmen.
#@Maike: stimmt

d <- density(stories$obs)
plot(d, main="Kernel Density Plot - Stories", xlab="Observations")


## j) What is the difference between a histogram and a kernel density plot?
#@Martin: du schreibst echt viel. ich bin für deine version glaub ich.
#@Maike: OK

#@Martin: meine version.
#The histogram shows how often a value occurs in the data. The kernel density plot has normal distributions
#stacked on top of each other instead, so the plot is smoother.

#@Martin: deine Version.
# A histogram shows bars representing the frequencies of (a range of) observations, i.e. one
# observation more with a certain value will increase the bar for that value by one.
# A kernel density plot assumes a normal distribution for every singly data point and stacks
# the areas under the curves for all data points on top of each other.

## This is a difficult one, remember you just need to provide a serious attempt at solving each
## exercise in order to pass.
## k) Overlay the histogram with the kernel density plot
##    (hint: the area under the curve should be equal for overlaying the graphs
##    correctly.)

#@Martin: hier hab ich deins komplett übernommen.
#@Maike: Roger - ich hab's nur zu 1.P. plural geändert:
# Not sure if this is what you wanted to see. This is the closest we were able to figure out:
bin <- 8

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

#@Martin: man braucht also from und to nicht? Find ich aber schöner eigentlich.
#@Maike: Nein, braucht man nicht, wenn man die Werte in der richtigen Reihenfolge angibt
# und wichte Parameter nicht auslässt.
# Der Übersichtlichkeit halber mach ich es aber auch oft gern so,
# dass ich die Labels der Parameter mit reinnehme.
x <- seq(from = -5, to = 5, by = 0.1)

## b) Now we need to obtain the y-values of the plot (the density). We do this
##    using the density function for the normal distribution.
##    Use "help(dnorm)" to find out about the standard functions for the normal
##    distribution.

help(dnorm)
y <- dnorm(x)

#@Martin: ich hatte
#dnorm(x, mean = 0, sd = 1, log = FALSE)
#ich nehm also an, dass man das nicht braucht weil das default values sind?
#@Maike: Genau, das sind default values.

## c) Now use plot() to plot the normal distribution for z values of "x".

plot(x, y)

#@Martin: du hast hier den rest auskommentiert. Ich würds so lassen hier.
#@Maike: Ja, ich hab da ein bisschen herumexperimentiert, bevor ich weiter gelesen hab.

## d) The plot now has a relatively short y-range, and it contains circles
##    instead of a line.
##    Using plot(), specify the y axis to range from 0 to 0.8, and plot a line
##    instead of the circles.

#@Martin: hier hab ich deins genommen, war das gleiche bis auf Farbe und Breite der linie
#@Maike: OK
plot(x, y, type="l", col="blue", lwd=2, ylim=c(0, 0.8))


## e) We want to have a vertical line to represent the mean of our distribution.
##    'abline()' can do this for us. Look up help for abline().
##    Use abline() to create the vertical line. Specify the median of x using
##    the argument 'v'.
##    In order to get a dashed line, set the argument 'lty' to 2.

help(abline)

#@Martin: hier hab ich unsere Codes kombiniert. Du hattest mean statt median,
#und ich hab deine Farben dazu genommen.
#@Maike: Ups. OK, passt.

plot(x, y, type = "l", col="blue", lwd=2, ylim = c(0, 0.8))
abline(v = median(x), lty = 2)

## f) Take a look at the beaver1 dataset. (You can see it by typing "beaver1".)
##    Then select only the temperature part and store it in a variable "b1temp".

#@Martin: ich hatte das mit b1temp <- select(beaver1, temp) gemacht, finde deins
#aber schöner.
#@Maike: Alles klar. 

b1temp <- beaver1$temp

## g) Calculate the mean and standard deviation of this dataset and plot a normal
##    distribution with these parameters.

#@Martin: wenn wir oben meine variante mit select genommen hätten,
#wäre b1temp ein dataset und keine variable.
#Dann bräuchte man bei mean() und sd() b1temp$temp.
#Jetzt bin ich mir gar nicht mehr sicher, was besser ist. Select oder das andere.
#@Maike: Ich glaube im Endeffekt ist es egal. Aber die gesamt elegantere Variant ist
# vermutlich mit select() gleich einen Dataframe zu bekommen. Ich schlage trotzdem vor,
# es mit meiner "groberen" Variante einzureichen und so auf entsprechendes negatives
# Feedback zu hoffen.

b1_mn <- mean(b1temp)
b1_sd <- sd(b1temp)
dens_b1_temp <- dnorm(b1temp, b1_mn, b1_sd)

plot(b1temp, dens_b1_temp, col="blue")

#@Martin: ok. hier versteh ich was nicht. ich hatte das hier:
#plot(dens_b1_temp, type = "l")
#und was da raus kommt sieht gar nicht richtig aus.
#ich versteh aber nicht warum wir b1temp hier wieder brauchen.
#@Maike: In der Version oben (die von mir) habe ich b1temp als x-Werte und dens_b1_temp als y-Werte definiert.
# Wenn man nur eine Datenreihe angibt, in deinem Bsp die y-Werte, dann nimmt R offensichtlich die Position
# eines Wertes im Vektor (also eigentlich Index) als Werte für die x-Achse. Das habe ich auch nicht gewusst
# und ist ziemlich cool, macht aber total Sinn.

## h) We observe two temparatures (36.91 and 38.13). What's the likelihood that
##    these temperatures (or more extreme ones) respectively come
##    from the normal distribution from g)?

#@Martin: hier weiß ich nicht so richtig was du machst, vor allem warum
#du das a und b nennst. Schau mal ob's so auch passt für dich.
#@Maike: Ich hab hier nur ein bisschen rumprobiert, weil mir bis zum Tutorium nicht klar war,
# was zu machen ist. Ich mag deine Lösungen aber sehr.

1 - pnorm((36.91-b1_mn)/b1_sd)
#The likeliness of 36.91 or more extreme values to come from the normal distibution g is 0.4023844.

1 - pnorm((38.13-b1_mn)/b1_sd)
#The likeliness of 38.13 or more extreme values to come from the normal distribution g is 2.78878e-11.

## i) Use the random sampling function in R to generate 20 random samples from
##    the normal distribution from g), and draw a histogram based on this sample.
##    Repeat 5 times. What do you observe?

#@Martin: ok. hier machen wir unterschiedliche Sachen.
#Du hast:

samp_1 <- sample(b1temp, 20)
samp_2 <- sample(b1temp, 20)
samp_3 <- sample(b1temp, 20)
samp_4 <- sample(b1temp, 20)
samp_5 <- sample(b1temp, 20)

#und ich hab:

b1 <- sample(dens_b1_temp, size = 20, replace = FALSE, prob = NULL)
b2 <- sample(dens_b1_temp, size = 20, replace = FALSE, prob = NULL)
b3 <- sample(dens_b1_temp, size = 20, replace = FALSE, prob = NULL)
b4 <- sample(dens_b1_temp, size = 20, replace = FALSE, prob = NULL)
b5 <- sample(dens_b1_temp, size = 20, replace = FALSE, prob = NULL)

#@Martin: also hab ich die samples aus der normal distibution genommen
#und du aus dem unsprünglicheren Datenset, oder?
#Jetz scheint deins besser auszusehen als meins, aber im Text steht
#was von normal distribution aus g). ??? Keine ahnung.
#@Maike: Ja stimmt. Ich dachte mir es macht wenig Sinn 'samples' aus den normal distributions zu nehmen.
# Aber du hast Recht -- auf slide 59 heißt es, man kann das auch mit distributions machen.
# Ich glaube, du hast das richtig gemacht. Versuch mal size auf 50 statt 20 zu setzen,
# dann siehst du besser was -- vielleicht -- rauskommen soll nämlich sowas wie negatively skewed.

#@Martin: und das sind meine Histogramme:

hist(b1, breaks = 10)
hist(b2, breaks = 10)
hist(b3, breaks = 10)
hist(b4, breaks = 10)
hist(b5, breaks = 10)

#@Martin: und hier deine:

hist(x = samp_1, main="Beaver 1 - Sample of 20", xlab="Measurements")
hist(x = samp_2, main="Beaver 1 - Sample of 20", xlab="Measurements")
hist(x = samp_3, main="Beaver 1 - Sample of 20", xlab="Measurements")
hist(x = samp_4, main="Beaver 1 - Sample of 20", xlab="Measurements")
hist(x = samp_5, main="Beaver 1 - Sample of 20", xlab="Measurements")

#@Martin: und unsere conclusions.

#Conclusion Maike:
#well they all look very different!


#Conclusion Martin:
# It seems that the samples are distributed kind of normally.
# At least, they fit 'into' or 'within' the curve of a normal distribution.
# Most of the time.