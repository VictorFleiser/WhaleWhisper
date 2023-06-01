function [result, sound_names] = analyzeSoundIntervals(list_y, list_fs, analysisFunction)
    % Initialize the result as an empty matrix
    result = [];
    sound_names = {};
    
   % Iterate over each sound segment
    for i = 1:numel(list_y)
        % Get the sound data and sample rate for the current interval
        y = list_y{i};
        fs = list_fs{i};
        
        % Call the provided analysis function with the sound data and sample rate
        [soundData, soundName] = analysisFunction(y, fs);
        
        % Transpose the soundData matrix to have 1 row and 8 columns
        soundData = soundData(:)';
        
        % Append the soundData to the result matrix
        result = [result; soundData];

        % Append the soundName to the sound_names list
        sound_names{end+1} = soundName;
    end
end
