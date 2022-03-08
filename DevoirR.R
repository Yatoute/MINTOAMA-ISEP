
#                     Exercice 1.1

# 1-Cr?ation de vecteurs ? l'aide de la fonction rep
vect1=rep(1:5, 3)
vect2= rep(1:5, each =3)
vect3 =rep(1:4, 2:5) #Rep?te chaque ?l?ment du vecteur 1:4 ? un nombre de fois correspond ?gal l'entier du vecteur 2:5 ayant le m?me indice que celui ci

# 2-Cr?ation de vecteurs avec la fonction paste

vect4 = paste("A", 0:10, sep="",recycle =")")

# 3-
post = which(letters=="q") #La position de la lettre q dans l'aphabet
vect = paste(letters[1: post], 1: post, sep="")


#          Exercice 1.2

# 1-G?n?rateur de nombre al?atoire

set.seed =007 #Fixation de la graine du g?n?rateur de nombre al?atoire ? la valeur 007
vec1 = runif(100, min=0, max=7) #vecteur de 100 nombre uniforment tir?s en 0 et 7
mean(vec1) # Moyenne des ?l?ment contenu dans vect1
var(vec1) # La variance des ?l?ments contenu dans vect1

# 2-

vec2 = vec1
set.seed =008 #Fixation de la graine du g?n?rateur de nombre al?atoire ? la valeur 008
vec2[vec2 %in% sample(vec2, size =10)] = NA #S?lectionner 10 cordonn?es au hassard et remplacer les valeur par NA
posts = which(is.na(vec2)) # Les cordonn?es des valeurs manquantes

# 3-
# Calcul de la moyenne sans gestion de valeur manquante
vec2
mean(vec2) # Moyenne des ?l?ment contenu dans vect2
var(vec2) # La variance des ?l?ments contenu dans vect2

# Calcul de la moyenne avec gestion de valeurs manquantes
mean(vec2, na.rm = TRUE ) # Moyenne des ?l?ments valides contenus dans vect2
var(vec2, na.rm = TRUE) # La variance des ?l?ments valides contenus dans vect2


# 4-

vec3 = vec2[-posts] # Vecteur obtenu ? partir de vec2 en supprimant ses cordonn?es qui contiennent une valeur manque
mean(vec3) # Moyenne des ?l?ment contenu dans vect3
var(vec3) # La variance des ?l?ments contenu dans vect3


# 5- Cr?ation d'un vecteur vec4 obtenu ? partir vec2 en rempla?ant les valeurs manquantes par la moyenne de vec3

vec4 = vec2
vec4[posts] = mean(vec3)
mean(vec4) # Moyenne des ?l?ment contenu dans vect4
var(vec4) # La variance des ?l?ments contenu dans vect4

# 6- Cr?ation d'un vecteur vec5 en rempla?ant les cordonn?es de vec2 qui contiennent des valeurs manquantes par un tirage al?atoire selon une loi normale de moyennes et d'?carts types ?gaux ? ceux de vec3
vec5 = vec2
vec5[posts]= rnorm(length(posts),mean(vec3),sd(vec3))
mean(vec5)
var(vec5)

# 7- Cr?ation d'un vecteur vec6 en rempla?ant les cordonn?es de vec2 qui contiennent des valeurs manquantes par un tirage al?atoire selon une loi uniforme entre le minimun et le mawimun de vec3
vec6=vec2
vec6[posts]=runif(length(posts),mean(vec3), max(vec3))
mean(vec6)
var(vec6)

# 8- Cr?ation d'un vecteur vec7 ? partir de vec2 en rempla?ant les NA par un tirage al?atoire avecremise parmi les valeurs non manquante de vec2
vec7 = vec2
vec7[posts]=sample(vec3,10)
mean(vec7)
var(vec7)


#                 Eexercice 1.3 (Cr?ation et inversion d'une matrice)

# 1- Cr?ation d'une matrice mat
mat=matrix(c(1,0,3,4,5,5,0,4,5,6,3,4,0,1,3,2),ncol=4)
rownames(mat)=paste("ligne",1:4, sep = "-")
colnames(mat)=paste("colonne", 1:4)

# 2-Vecteur colonnes des ?l?ments diagonaux de mat 
vec=diag(mat)

# 3- Une matrice contnant uniquement les deux premi?res lignes de mat
mat1 = mat[c(1,2),]

# 4- Une matrice contenant uniquement les deux derni?res colonnes de mat
mat2= mat[, (ncol(mat)-1):ncol(mat)]

# 5- Une matrice contenant toutes les colonnes de mat saufe la troisi?me
mat3 = mat[,-3]

# 6- Calcul du d?terminant et l'inverse de mat
det(mat) # d?terminant
solve(mat) # inverse de mat


#                   Exercise 1.4  (Selecting and Sorting in a  Data-Frame)

# 1.  The  iris data is loaded and a new dataset is created by selecting only the rows carrying the value "versicolor" for the Species variable:
  
data(iris)
iris2 <- iris[iris[,"Species"]=="versicolor", ]

# 2.  The  dataset is sorted according  to the first  variable  using  the order  func- tion:
  
iris2[order(iris2[,1],decreasing=TRUE),]
  


#                  Exercise 1.5  (Using the  apply  Function)

# 1.  To calculate  the benchmark  statistics, simply  use the summary  function:
  
library(lattice) # load the package
data(ethanol)
summary(ethanol)


# 2.  To calculate  the quartiles,  we can use the apply  function:
  
apply(X=ethanol,MARGIN=2,FUN=quantile)

#3.  The  instruction for the previous  question  by  default  yields  the quartiles. Indeed, since we have not specified the argument  probs for the quantile func- tion,  the argument  used by default  is:  probs=seq(0,0.25,0.5,0.75,1) (see the help section for the quantile function). To obtain deciles, we have to spec- ify  probs=seq(0,1,by=0.1) as the argument.  The  help section for the apply function  indicates  the  optional  arguments  via  ...: optional arguments to 'FUN'.  It is  therefore possible  to  "pass"  probs=seq(0,1,by=0.1) as  an argument  to the FUN=quantile function:
  
apply(ethanol,2,quantile,probs=seq(0,1,by=0.1))

#                 Exercise 1.6  (Selection in a  Matrix with the  apply  Function)

# 1.  The  matrix  containing  the columns  of mat having  all  values  smaller  than 6 is obtained as follows:
  
mat <- matrix(c(1,0,3,4,5,5,0,4,5,6,3,4,0,1,3,2),ncol=4)
mat3 <- mat[,apply((mat<6),2,all)]
mat3

#2.  Because  there  is  only  one row  which  do  not  contain  0,  we have  to  use drop=FALSE such that  the output  is a matrix  and not a vector:
  
mat4 <- mat[apply((mat>0),1,all),,drop=FALSE]
mat4


#                     Exercise 1.7  (Using the  lapply  Function)

# 1.  The  MASS package and the dataset Aids2 are loaded: 
  
library(MASS)  # load the package
data(Aids2)
summary(Aids2)

#2.  The  function is.numeric  returns a boolean: TRUE when the object on which it is applied is numeric.  We have to apply  this function  to each column of the data-frame  Aids2 and take the negation (operator  !).  As  the data-frame  is a list,  applying a function  to each column  is (usually) equivalent  to applying a function to each component of the list;  this is the scope of the lapply function:
  
ind <- !unlist(lapply(Aids2,is.numeric))

#3.  We just  have to select the variables  of the data-frame  using  ind:
  
Aids2.qual <- Aids2[,ind]

# 4.  We use the levels function  on each element of the data-frame  Aids2.qual:
  
lapply(Aids2.qual,levels)


         # Exercise 1.8  (Levels of  the Qualitative Variables in a  Subset)

# 1.  The  package MASS and the dataset Aids2 are loaded:
  
library(MASS)  # load the package
data(Aids2)

# 2.  The  selection is done as follows:
  
res <- Aids2[(Aids2[,"sex"]=="M")&(Aids2[,"state"]!="Other"),]

# 3.  The  summary  indicates  that  the levels are still  the same, M and F, but  no individuals take the category  F.

summary(res)

# 4.  The  attributes  of sex are:
  
attributes(res[,"sex"])

# 5.  We  transform  the sex variable  into  a character  object  and  print  the at- tributes  of the resulting  object:
  
sexc <- as.character(res[,"sex"])
attributes(sexc)

# 6.  Transform the sexc into a factor:
  
sexf <- as.factor(sexc)
attributes(sexf)

# 7.  We select the indices of the non-numeric  variables:
  
ind <- !unlist(lapply(res,is.numeric))
ind

# 8.  We transform  the selected variables  into character:
  
res[,ind] <- lapply(res[,ind],as.character)

# 9.  We transform  the selected variables  into factors:
  
res[,ind] <- lapply(res[,ind],as.factor)
summary(res)


