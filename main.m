clear all;
close all;
clc;

% ouverture du fichier texte 'sounds_starts_ends.txt' pour récupérer le nom
% du ficher audio à analyser ainsi que les débuts et fins (en secondes) des
% sons à analyser
[audioFileName, soundSegments] = get_start_end_intervals('sounds_starts_ends.txt');

% Recupère tous les sons coupés ainsi que la fréquence d'échantillonage
[list_y, list_fs] = readAudioSection(audioFileName, soundSegments);

% Analyse de tous les sons en utilisant la fonction passée en dernier arg
% retourne le tableau avec les colonnes représentant chaque son analysé et 
% les lignes chaque critère d'analyse
[soundData, soundName, spectrogramData] = analyzeSoundIntervals(list_y, list_fs, @tableauValeurNomDefaut);

end_second = 4.5;

% création de l'interface graphique affichant la baleine trouvée, un
% spectrogramme au choix, et le tableau des sons analysés par les critères

gui("Baleine Bleue", spectrogramData, soundSegments, list_fs, soundData, soundName);

