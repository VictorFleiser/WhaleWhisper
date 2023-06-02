function [valCritere] = mesureMinMaxDebutFinCritere(y, fs)

% Détection de la fréquence fondamentale
frequence_fondamentale = [];

fenetre_temporelle = 0.03;

pas_temporel = 0.01;

seuil_amplitude = 0.5; % Seuil d'amplitude pour la détection des harmoniques

taille_fenetre = round(fenetre_temporelle * fs);

pas_fenetre = pas_temporel * fs;

% Parcours de l'enregistrement audio avec une fenêtre glissante
for i = 1:pas_fenetre:(length(y) - taille_fenetre)
    % Extraction de la fenêtre temporelle
    fenetre = y(i:i+taille_fenetre-1);
    
    % Calcul du spectre de puissance
    spectre = abs(fft(fenetre));
    spectre = spectre(1:round(length(spectre)/2)); % Garder uniquement la moitié positive du spectre
    spectre = spectre / max(spectre); % Normalisation
    
    % Détection des harmoniques
    indices_harmoniques = find(spectre > seuil_amplitude);
    
    % Si des harmoniques sont détectés, prendre le premier comme fréquence fondamentale
    if ~isempty(indices_harmoniques)
        frequence_fondamentale = [frequence_fondamentale, indices_harmoniques(1) * (fs / taille_fenetre)];
    end
end



% Calcul des valeurs demandées
varmin = min(frequence_fondamentale);
varmax = max(frequence_fondamentale);
varstart = frequence_fondamentale(1);
varend = frequence_fondamentale(end);
moyenne_frequence_fondamentale = mean(frequence_fondamentale);


valCritere = [varmin, varmax, varstart, varend, moyenne_frequence_fondamentale];

end
