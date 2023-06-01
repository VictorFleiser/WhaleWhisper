# WhaleWhisper
Projet de traitement de signal

Codes à faire :

-----

Fonction analysant un son selon les 8 (?) critères.

Renvoie une liste des 8 valeurs mesurées ainsi que le nom du son.

En paramètres : y la liste avec les données du son récupérées avec audioread(); fs la fréquence d'échantillonage

Signature : 

function [soundData, soundName] = mesureCriteres(y, fs)

-----

Fonction déterminant l'espece de la baleine à partir du tableau des critères mesurés.

Renvoie une une chaine de charactères avec la baleine trouvée, valeurs possibles : "Baleine a Bosse" ou "Baleine Bleue" ou "Baleine Boréale" ou "Rorqual commun".

En paramètres : le tableau avec les valeurs mesurées, avec en colonne le ième son et en lignes les valeurs des 8 (?) critères mesurés

Signature : 

function [whaleName] = determineSpecies(tableauCriteres)

-----

Les fonctions appelées par mesureCriteres() s'occupant de mesurer chaque critères

Renvoient la valeur mesurée.

En paramètres : y la liste avec les données du son récupérées avec audioread(); fs la fréquence d'échantillonage

Signature : 

function [valCritere] = mesureNomCritere(y, fs)
