clear all;
close all;
clc;

%Valeur entre 0 et 1
seuil_amplitude = 0.5;

%Booléen pour savoir si appliquer un filtre (n'est pas appliqué sur le spectrogramme la mtn
filtreBool = false;

% ouverture du fichier texte 'sounds_starts_ends.txt' pour récupérer le nom
% du ficher audio à analyser ainsi que les débuts et fins (en secondes) des
% sons à analyser
[audioFileName, soundSegments] = get_start_end_intervals('sounds_starts_ends.txt');

% Recupère tous les sons coupés ainsi que la fréquence d'échantillonage
[list_y, list_fs] = readAudioSection(audioFileName, soundSegments);

% Analyse de tous les sons en utilisant la fonction passée en dernier arg
% retourne le tableau avec les colonnes représentant chaque son analysé et 
% les lignes chaque critère d'analyse
[soundData, soundName, spectrogramData] = analyzeSoundIntervals(list_y, list_fs, @mesureCriteres, soundSegments, seuil_amplitude, filtreBool);

% création de l'interface graphique affichant la baleine trouvée, un
% spectrogramme au choix, et le tableau des sons analysés par les critères


Categories = {'Durée (sec)', 'Fréq minimum (Hz)', 'Fréq maximum (Hz)', 'Fréq début (Hz)', 'Fréq fin (Hz)', 'Fréq moyenne (Hz)', 'Equart Max-Min'};

% Initialize variables
[row, col] = size(soundData);
colIndex = 1;

% While loop to calculate and print mean of each column
while colIndex <= col
    currentColumn = soundData(:, colIndex);
    colMean = mean(currentColumn);
    colName = Categories{colIndex};
    fprintf('Mean value of %s is: %.2f\n', colName, colMean);
    colIndex = colIndex + 1;
end

gui("Baleine a Bosse", spectrogramData, soundSegments, list_fs, soundData, soundName);

