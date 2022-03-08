
# I- Importation des bases se trouvant à l'intérieur du dossier Base_Etudiant

CheminAcess = "G:\\ISEP2\\ISEP Semestre 4\\Programmation sur R\\Base_etudiant"
setwd(CheminAcess)
library(haven)
library(readxl)
Cereales = read_dta(file=paste(CheminAcess, "cereales.dta", sep="\\"))
View(Cereales)
Ehcvm21 = read_dta(file=paste(CheminAcess, "Ehcvm21.dta", sep="\\"))
View(Ehcvm21)
Legumes = read_dta(file=paste(CheminAcess, "legumes.dta", sep="\\"))
View(Legumes)
table_conversion = read_dta(file=paste(CheminAcess, "table_conversion.dta", sep="\\"))
View(table_conversion)
ehcvm21_conso_red = read.csv(file=paste(CheminAcess, "ehcvm21_conso_red.csv", sep = "\\"), sep=";",header = TRUE)
View(ehcvm21_conso_red)
base_table = read_excel(path=paste(CheminAcess, "table_conversion_2021.xlsx", sep="\\"))
View(base_table)



# II- Renomencrature des variables de la base céréales

old_name = colnames(Cereales)
colnames(Cereales)=c(old_name[1],old_name[2],"cereales_id1","autre_cereales", "quantite_cons", 
                     "unites_cons","taille_cons","provenance_auto","provenance_other",
                     "freq_achat","quantite_achat", 
                     "unite_achat","taille_achat","value_lastachat")

colnames(base_table)



# III- Convertion des unités non standard en unité standart
library(dplyr)
library(lessR)
## extraction des variables "produitID"  "produitNom"
colnames(base_table)
produit = subset(base_table, select = c("produitID","produitNom"))

## suppresion des doublons; 
duplicated(produit)
produit_df <- distinct(produit) # supprime les données dupliqués 
str(produit_df)

## creer une nouvelle variable
# liste des produits 
Cereales$produit <-factor(Cereales$cereales_id1,
                           levels = produit_df$produitID, 
                           labels = produit_df$produitNom) 

glimpse(Cereales)

## faire la mme chose pour les unités et les tailles
uniteCons <- subset(base_table, select = c("uniteID", "uniteNom"))
tailleCons <- subset(base_table, select = c("tailleID", "tailleNom"))
## supression de doublons
uniteCons_df <- distinct(uniteCons)
tailleCons_df <- distinct(tailleCons)
Cereales$unites <- factor(Cereales$unites_cons, 
                           levels = uniteCons_df$uniteID, 
                           labels = uniteCons_df$uniteNom)
Cereales$tailles <- factor(Cereales$taille_cons,
                            levels = tailleCons_df$tailleID,
                            labels = tailleCons_df$tailleNom)


str(produit)


# Conversion des quantités selon les unités et les taille
# conversion des quantité en Kg
list_unit <- unique(Cereales$unites)
list_taille <- unique(Cereales$tailles)
glimpse( base_table)

# on doit merger la table de conversion avec la base cereale *
colnames(Cereales)[3] <- "produitID"
cereal1 <- merge(Cereales, base_table, by="produitID")
glimpse(cereal1)
head(cereal1)
# conversion 
attach(cereal1)
poids = as.numeric(poids)
quantite_achat = as.numeric(quantite_achat)
quantite_cons = as.numeric(quantite_cons)
#consommation 
cereal1$Consumption <- ((quantite_cons*poids/1000)/7)*365 # qtité en KG
label(data=cereal1,Consumption, "Consommation anuelle des ménages en Kg")
boxplot(cereal1$Consumption[cereal1$Consumption<50], col="red", horizontal = TRUE)

## achat
Cereales$freq_achat <- ordered(Cereales$freq_achat, 
                                levels=c(1,2,3,4,5),
                                labels=c("Hier","7 derniers jours", 
                                         "30 derniers jours",
                                         "Plus de 30 jours","Jamais"))
cereal1$Achat <- ((quantite_achat*poids/1000))# qtité en KG
label(data=cereal1,Consumption, "Qtité achété des ménages en Kg")

# cacule du prix d'achat
# conversion 
attach(cereal1)
value_lastachat =as.numeric(value_lastachat)
Achat =as.numeric(Achat)
cereal1$PrixKg <- value_lastachat/Achat # qtité en KG
label(data=cereal1,Consumption, "Prix d'achat unitaire au Kg")

## Valeur en Fcfa de la qtité anuel consommé 
# conversion 
attach(cereal1)
PrixKg =as.numeric(PrixKg)
Consumption =as.numeric(Consumption)
cereal1$Valeur <- PrixKg*Consumption # qtité en KG
label(data=cereal1,Consumption, "Prix d'achat unitaire au Kg")
glimpse(cereal1)