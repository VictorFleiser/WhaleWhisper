function species = determineSpecies(newValues, speciesData, weights, speciesNames)

% Initialize variables
    numSpecies = size(speciesData, 1);
    similarityScores = zeros(numSpecies, 1);

    % Calculate similarity score for each species
    for i = 1:numSpecies
        % Get the data for the current species
        speciesValues = speciesData(i, :);
        
        % Calculate the weighted sum of differences
        diff = speciesValues - newValues;
        weightedDiff = diff .* weights;
        similarityScores(i) = sum(abs(weightedDiff));
        fprintf('Similarité à %s : %.2f\n', speciesNames(i), similarityScores(i));
    end
 
    % Find the species with the minimum similarity score
    [~, speciesIndex] = min(similarityScores);
%    species = speciesData(speciesIndex, :);
    if (speciesIndex == 1)
        species = "Baleine Bleue";
    elseif (speciesIndex == 2)
        species = "Baleine a Bosse";
    elseif (speciesIndex == 3)
        species = "Baleine Boréale";
    else
        species = "Rorqual commun";
    end
end
