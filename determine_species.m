function [whaleName] = determineSpecies(tableauCriteres)
    % Critères moyens pour chaque espèce de baleine
    criteresBaleineABosse = [valeurCritere1, valeurCritere2, ..., valeurCritere8];  
    criteresBaleineBleue = [valeurCritere1, valeurCritere2, ..., valeurCritere8];  
    criteresBaleineBoreale = [valeurCritere1, valeurCritere2, ..., valeurCritere8]; 
    criteresRorqualCommun = [valeurCritere1, valeurCritere2, ..., valeurCritere8];  
    
    % Calcul de la distance entre les critères mesurés et les critères moyens pour chaque espèce
    distanceBaleineABosse = norm(tableauCriteres - criteresBaleineABosse);
    distanceBaleineBleue = norm(tableauCriteres - criteresBaleineBleue);
    distanceBaleineBoreale = norm(tableauCriteres - criteresBaleineBoreale);
    distanceRorqualCommun = norm(tableauCriteres - criteresRorqualCommun);
    
    % Détermination de l'espèce de baleine en fonction de la plus petite distance
    distances = [distanceBaleineABosse, distanceBaleineBleue, distanceBaleineBoreale, distanceRorqualCommun];
    [~, indexEspece] = min(distances);
    
    % Assignation du nom de l'espèce de baleine correspondante
    switch indexEspece
        case 1
            whaleName = 'Baleine a Bosse';
        case 2
            whaleName = 'Baleine Bleue';
        case 3
            whaleName = 'Baleine Boreale';
        case 4
            whaleName = 'Rorqual commun';
        otherwise
            whaleName = 'Espèce inconnue';
    end
end

