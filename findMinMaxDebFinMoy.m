function [retour] = findMinMaxDebFinMoy(segment, fs, seuil_amplitude, filtreBool)
% Fréquence fondamentale

% Charger l'enregistrement audio
%[audio, fs] = audioread('Bbleu.wav');
%audio = audio(:, 1); % Sélectionner une seule piste audio si l'enregistrement en contient plusieurs

% Paramètres
fenetre_temporelle = 0.03; % Taille de la fenêtre temporelle en secondes
pas_temporel = 0.01; % Pas temporel entre deux fenêtres en secondes
%seuil_amplitude = 0.9; % Seuil d'amplitude pour la détection des harmoniques
frequence_echantillonnage = fs; % Fréquence d'échantillonnage de l'enregistrement audio

if (filtreBool)
    [segment] = filtre(segment, fs);
end

% Convertir les paramètres en échantillons
taille_fenetre = round(fenetre_temporelle * frequence_echantillonnage);
pas_fenetre = round(pas_temporel * frequence_echantillonnage);

% Détection de la fréquence fondamentale
frequence_fondamentale = [];

% Parcours de l'enregistrement audio avec une fenêtre glissante
for i = 1:pas_fenetre:(length(segment) - taille_fenetre)
    % Extraction de la fenêtre temporelle
    fenetre = segment(i:i+taille_fenetre-1);
    
    % Calcul du spectre de puissance
    spectre = abs(fft(fenetre));
    spectre = spectre(1:round(length(spectre)/2)); % Garder uniquement la moitié positive du spectre
    spectre = spectre / max(spectre); % Normalisation
    
    % Détection des harmoniques
    indices_harmoniques = find(spectre > seuil_amplitude);
    
    % Si des harmoniques sont détectés, prendre le premier comme fréquence fondamentale
    if ~isempty(indices_harmoniques)
        frequence_fondamentale = [frequence_fondamentale, indices_harmoniques(1) * (frequence_echantillonnage / taille_fenetre)];
    end
end

% Calcul de la moyenne de la fréquence fondamentale
val_min = min(frequence_fondamentale);
val_max = max(frequence_fondamentale);
val_start = frequence_fondamentale(1);
val_end = frequence_fondamentale(end);
moyenne_frequence_fondamentale = mean(frequence_fondamentale);

retour = {val_min, val_max, val_start, val_end, moyenne_frequence_fondamentale};
 