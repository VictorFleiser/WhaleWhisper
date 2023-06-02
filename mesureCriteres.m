function [soundData, soundName] = mesureCriteres(y, fs, start, finish, seuil_amplitude, filtreBool)

    soundData = zeros(1, 7);

    % Durée
    soundData(1) = finish - start;
    
    %Min, Max, Deebut, Fin, Moyenne
    valCritere = findMinMaxDebFinMoy(y, fs, seuil_amplitude, filtreBool);
    soundData(2) = valCritere{1};   %Min
    soundData(3) = valCritere{2};   %Max
    soundData(4) = valCritere{3};   %Start
    soundData(5) = valCritere{4};   %End
    soundData(6) = valCritere{5};   %Mean

    % intervalle
    soundData(7) = valCritere{2} - valCritere{1};
        
    soundName = 'Sound Name';
end