function [filteredSegment] = filtre(signal, fs)
    % Définition des paramètres du filtre
    cutoffFreq = 1000; % Fréquence de coupure du filtre
    filterOrder = 12; % Ordre du filtre

    segment = signal;

    % Création du filtre passe-bas
    [b, a] = butter(filterOrder, cutoffFreq / (fs / 2), 'low');

    % Filtrage du segment audio
    filteredSegment = filter(b, a, segment);

    % Création d'un signal filtré avec le segment sélectionné
%    filteredSignal = zeros(size(signal));
 %   filteredSignal(startSample:endSample) = filteredSegment;
end