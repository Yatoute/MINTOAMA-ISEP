#Chapitre 2 : Manipulation et description des données avec R (6h)
# Importation des données
## https://bookdown.org/fousseynoubah/dwsr_book/importer-des-donnees-dans-r.html

## Get to know !!
# On définit notre espace de travail si besoin
chemin <- "D:\\Laptop 2021\\ENSAE\\TDr"
setwd(chemin)

# On créé plusieurs variables
nombre <- 7
nom <- "Assimi"

# On sauvegarde ces variables dans un même fichier de sauvegarde
save(nombre, nom, file="nombre.nom.RData")

# On efface ces variables
rm(nombre, nom)

# Et on les réimporte grace à la fonction load
import <- load("nombre.nom.RData")

# On affiche le nom des variables importées
print(import)

# Et leur contenu
print(nombre)
print(nom)

# chemin d'accés des données
# dir <- "C:\\Users\\HP820\\Desktop\\ANSD\\Suivi QG EHCVM 2 V1\\Base2018"
# setwd(dir)
# ?read.csv
sourceDonnees <-  "C:\\Users\\HP820\\Desktop\\ANSD\\Suivi QG EHCVM 2 V1\\Base2018\\" 
mesdonnees <- read.csv(
  # Spécifier le nom du fichier
  file = paste0(sourceDonnees, "ehcvm18_men.csv"), 
  # Déclarer la première ligne comme nom de colonne/variable
  header = TRUE, 
  # Déclarer le point virgule comme séparateur
  sep = ";", 
  # Ne pas systématiquement transformer les caractères en facteurs.
  stringsAsFactors = TRUE 
)
# voir la structure des données;
str(mesdonnees)
View(mesdonnees)

# Importation avec R-base: read.csv2
# homework : différence entre read.csv et read.csv2? 

# Importation avec readr
## read_csv et read_csv2

# Chargement du package "readr"
library(readr) 
# Importation du fichier
mesdonnees1 <- read_csv2(
  # Spécifier le nom du fichier
  file = paste0(sourceDonnees, "ehcvm18_men.csv"), 
  # Déclarer la première ligne comme nom de colonne/variable
  col_names = TRUE, 
  # Indiquer la valeur à attribuer aux cellules vides 
  na = "vide", 
  # Nombre de lignes à ne pas importer, partant du ficher
  skip = 0
)

mesdonnees1 <- read_csv2(
  # Spécifier le nom du fichier
  file = paste0(sourceDonnees, "ehcvm21_conso.csv"), 
  # Déclarer la première ligne comme nom de colonne/variable
  col_names = TRUE, 
  # Indiquer la valeur à attribuer aux cellules vides 
  na = "", 
  # Nombre de lignes à ne pas importer, partant du ficher
  skip = 0, 
  show_col_types = FALSE
)

str(mesdonnees1)
View(mesdonnees1)

## read_csv est un cas spécifique d’une fonction généraliste 
## qui couvre un large spectre de formats : read_delim.

## Avec read_delim, divers format de fichiers peuvent être importés,
  ## à partir du moment où le séparateur est bien spécifié:



# Chargement du package "readr"
library(readr) 
# Importation du fichier
mesdonnees2 <- read_delim(
  # Spécifier le nom du fichier
  file = paste0(sourceDonnees, "ehcvm_men.txt"), 
  # Indiquer le séparateur
  delim = ";",
  show_col_types = FALSE
)

#  Excel: xls, xlsx
## Importation avec xlsx: read.xlsx

# Ne pouvant accéder au fichier depuis le net,
# il faut le télécharger localement d'abord.
#library(downloader)
#download(url = paste0(masource, "NomFichier.xls"), dest = "ehcvm.xls", mode="wb")

# Chargement du package "xlsx"
library(xlsx)
setwd(dir)
# Exemple avec fichier Excel 97-2003
ehcvm_xls <- read.xlsx( 
  # Spécifier le nom du fichier (format "xls")
  file = "ehcvm18_men.xls", 
  # Indiquer le numéro d'ordre de l'onglet à importer
  sheetIndex = 1, 
  # Déclarer la première ligne comme nom de colonne/variable
  header = TRUE
)
str(ehcvm_xls)
## Importation avec readxl: read_excel
library(readxl)
# Exemple avec fichier Excel 2007-plus
ehcvm_men_xls <- read_excel(
  # Spécifier le nom du fichier (format "xls")
  path = "ehcvm18_men.xlsx", 
  # indiquer le nom de l'onglet ou le numéro d'ordre, les deux sont acceptés
  # sheet = "ehcvm", 
  # Déclarer la première ligne comme nom de colonne/variable
  col_names = TRUE
)
 
View(ehcvm_men_xls)

#Importation avec foreign
# Le package foreign permet d’ouvrir des fichiers dta, issus de Stat
## from stata 
# Importation
library(foreign)
ehcvm_stata <- read.dta(
  # Spécifier le nom du fichier
  file = "ehcvm_consommation.dta",
  # Conversion des dates du format Stata au format R (pour dire simple)
  convert.dates = TRUE, 
  # Conversion des étiquettes de variables catégorielles en facteurs
  convert.factors = TRUE, 
  # Convertir "_" de Stata en "." dans R (surtout nom des variables)
  convert.underscore = FALSE, 
  # Donner ou pas une valeur particulière aux cellules vides?
  missing.type = FALSE, 
  # Si oui, cet argument indique si cette valeur est présente ou pas
  warn.missing.labels = TRUE 
)
# out of version ! take only from 5 to 12's stata version  
# Importation avec foreign
# Chargement du package "foreign"
library(haven) 

# Importation

ehcvm_stata1 <- read_dta(
  # Spécifier le nom du fichier
  file = "s00_me_SEN2018.dta", 
  # Conservation des étiquettes de variables catégorielles (facteurs)
  use.value.labels = TRUE, 
  # Importation en data frame au lieu de matrice
   to.data.frame = TRUE 
)


#Base de données relationnelles ; 
## Importation avec RODBC
## Importation avec odbc
## Depuis Internet


# Graphiques
View(ehcvm_stata1)

# Calcul des paramètres de position
# Calcul des paramètres de dispersion
# Exportation des données
