function [result, sound_names, spectrogramData] = analyzeSoundIntervals(list_y, list_fs, analysisFunction, soundSegments, seuil_amplitude, filtreBool)
    % Initialize the result as an empty matrix
    result = [];
    sound_names = {};
    spectrogramData = {};
    
   % Iterate over each sound segment
    for i = 1:numel(list_y)
        % Get the sound data and sample rate for the current interval
        y = list_y{i};
        fs = list_fs{i};
        
        start_end = {soundSegments(1, i), soundSegments(2, i)};

        % Call the provided analysis function with the sound data and sample rate
        [soundData, soundName] = analysisFunction(y, fs, start_end{1}, start_end{2}, seuil_amplitude, filtreBool);
        
        % Transpose the soundData matrix to have 1 row and 8 columns
        soundData = soundData(:)';
        
        % Append the soundData to the result matrix
        result = [result; soundData];

        % Append the soundName to the sound_names list
        sound_names{end+1} = soundName;

        if filtreBool
            y = filtre(y, fs);
        end

        % Spectrogramme
        [spectrogramme, ~, ~, ~] = spectrogram(y, hann(1024), 512, 1024, fs, 'yaxis');
        spectrogramData{end+1} = spectrogramme;
    end
end
