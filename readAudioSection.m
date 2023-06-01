function [list_y, list_fs] = readAudioSection(audioFileName, soundSegments)
    % Read the audio file
    [y, fs] = audioread(audioFileName);
    
    % Initialize lists to store the Y and FS for each sound segment
    list_y = cell(1, size(soundSegments, 2));
    list_fs = cell(1, size(soundSegments, 2));
    
    % Iterate over each sound segment
    for i = 1:size(soundSegments, 2)
        % Extract the start and end seconds from the soundSegments matrix
        startSecond = soundSegments(1, i);
        endSecond = soundSegments(2, i);
        
        % Convert the start and end seconds to sample indices
        startIndex = round(startSecond * fs) + 1;
        endIndex = round(endSecond * fs) + 1;
        
        % Extract the sound segment from the original audio data
        soundSegment = y(startIndex:endIndex);
        
        % Store the sound segment and its corresponding sample rate
        list_y{i} = soundSegment;
        list_fs{i} = fs;
    end
end
