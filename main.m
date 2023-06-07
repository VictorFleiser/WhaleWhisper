clear all;
close all;
clc;

%Valeur entre 0 et 1
seuil_amplitude = 0.9;

% Booléen pour savoir si appliquer un filtre
filtreBool = false;

%% ouverture du fichier texte 'sounds_starts_ends.txt' pour récupérer le nom
% du ficher audio à analyser ainsi que les débuts et fins (en secondes) des
% sons à analyser
[audioFileName, soundSegments] = get_start_end_intervals('sounds_starts_ends_baleine_a_bosse.txt');

%% Recupère tous les sons coupés ainsi que la fréquence d'échantillonage
[list_y, list_fs] = readAudioSection(audioFileName, soundSegments);

%% Analyse de tous les sons en utilisant la fonction passée en dernier arg
% retourne le tableau avec les colonnes représentant chaque son analysé et 
% les lignes chaque critère d'analyse
[soundData, soundName, spectrogramData] = analyzeSoundIntervals(list_y, list_fs, @mesureCriteres, soundSegments, seuil_amplitude, filtreBool);


%% Affichage des moyennes
Categories = {'Durée (sec)', 'Fréq minimum (Hz)', 'Fréq maximum (Hz)', 'Fréq début (Hz)', 'Fréq fin (Hz)', 'Fréq moyenne (Hz)', 'Equart Max-Min'};

% Initialize variables
[row, col] = size(soundData);
colIndex = 1;
meanCategories = [];

% While loop to calculate and print mean of each column
while colIndex <= col
    currentColumn = soundData(:, colIndex);
    colMean = mean(currentColumn);
    meanCategories = [meanCategories, colMean];
    colName = Categories{colIndex};
    fprintf('Valeur moyenne de %s : %.2f\n', colName, colMean);
    colIndex = colIndex + 1;
end

%% Determination de l'espèce :
% Measured values for each species
if filtreBool == true
    baleineBleue = [0, 150.00, 300.00, 200.00, 250.00, 205.94, 150.00];
    baleineBosse = [0, 327.27, 721.21, 527.27, 518.18, 493.02, 392.94];
    baleineBoreale = [0, 33.33, 648.17, 33.33, 41.67, 43.18, 614.84];
%    baleineBoreale = [0, 183.45, 777.17, 283.51, 380.24, 382.90, 593.71];
else
    baleineBleue = [0, 141.67, 300.00, 200.00, 250.00, 205.83, 158.33];
    baleineBosse = [0, 330.30, 1545.45, 581.82, 551.52, 598.34, 1215.15];
    baleineBoreale = [0, 33.33, 725.96, 33.33, 41.67, 44.21, 692.62];
%    baleineBoreale = [0, 200.13, 1714.44, 396.92, 476.97, 460.66, 1514.31];
end

% Create a matrix with the measured values for each species
speciesData = [baleineBleue; baleineBosse; baleineBoreale];

% Define the weights for each criterion
weights = [0, 0.5, 1, 1, 1, 3, 1];

speciesNames = ["Baleine Bleue", "Baleine a Bosse", "Baleine Boréale", "Rorqual commun"];

% Determine the species
species = determineSpecies(meanCategories, speciesData, weights, speciesNames);

%% création de l'interface graphique affichant la baleine trouvée, un
% spectrogramme au choix, et le tableau des sons analysés par les critères
gui(species, spectrogramData, soundSegments, list_fs, soundData, soundName, list_y);

