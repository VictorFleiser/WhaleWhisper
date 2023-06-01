%Fonctions à implémenter : extract_caracteristiques(y, fs):
%                        :predcit pour réaliser la comparaison des sons



% Base de données contenant les différentes espèces de baleines les différentes espèces de baleines
espece1_audio_samples = <échantillons audio pour espèce 1>;
espece1_labels = 'Baleine_à_bosse';
espece1_features = <caractéristiques pour espèce 1>;

espece2_audio_samples = <échantillons audio pour espèce 2>;
espece2_labels = 'Baleine bleue';
espece2_features = <caractéristiques pour espèce 2>;

espece3_audio_samples = <échantillons audio pour espèce 3>;
espece3_labels = 'Baleine_boréale'
espece3_features = <caractéristiques pour espèce 3>;

espece4_audio_samples = <échantillons audio pour espèce 4>;
espece4_labels = 'Rorqual_commun'
espece4_features = <caractéristiques pour espèce 4>;

% Organiser les données dans une structure ou une cellule
donnees_baleines.espece1.audio_samples = espece1_audio_samples;
donnees_baleines.espece1.labels = espece1_labels;
donnees_baleines.espece1.features = espece1_features;

donnees_baleines.espece2.audio_samples = espece2_audio_samples;
donnees_baleines.espece2.labels = espece2_labels;
donnees_baleines.espece2.features = espece2_features;

donnees_baleines.espece3.audio_samples = espece3_audio_samples;
donnees_baleines.espece3.labels = espece3_labels;
donnees_baleines.espece3.features = espece3_features;

donnees_baleines.espece4.audio_samples = espece4_audio_samples;
donnees_baleines.espece4.labels = espece4_labels;
donnees_baleines.espece4.features = espece4_features;


% Sauvegarder les données dans un fichier MAT
save('donnees_apprentissage.mat', 'donnees_apprentissage');





% Chargement des données contenant les différentes espèces de baleines.
load('donnees_baleines.mat'); 
% Charger le fichier audio choisi par l'utilisateur
disp('Choisissez un fichier audio contenant le son des baleines :');
[filename, filepath] = uigetfile('*.wav', 'Sélectionnez un fichier audio');

% Vérifier si un fichier a été sélectionné
if isequal(filename, 0)
    disp('Aucun fichier sélectionné. Le programme se termine.');
    return;
end


% Charger le fichier audio
[y, fs] = audioread(fullfile(filepath, filename));

% Extraire les caractéristiques du fichier audio
features = extract_caracteristiques(y, fs); % Fonction à définir pour extraire les caractéristiques audio

% Charger le modèle de classification pré-entrainé
load('modele_classification.mat'); % Remplacez 'modele_classification.mat' par le nom de votre fichier contenant le modèle de classification

% Prédire l'espèce de baleine
speciesPrediction = predict(speciesClassifier, features); % Remplacez 'speciesClassifier' par le nom de votre classifieur pré-entrainé

% Afficher le résultat de la prédiction
disp(['Espèce de baleine prédite : ' speciesPrediction]);

% Afficher le spectrogramme du son
windowSize = 1024;        % Taille de la fenêtre d'analyse (ajustez selon vos besoins)
overlapRatio = 0.5;       % Taux de recouvrement des fenêtres (ajustez selon vos besoins)

figure;
spectrogram(y, windowSize, round(overlapRatio*windowSize), [], fs, 'yaxis');
title(['Spectrogramme du son des baleines : ' speciesPrediction]);
colorbar;