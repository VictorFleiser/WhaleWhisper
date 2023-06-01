function [audioFileName, soundSegments] = get_start_end_intervals(fileName)
    % Open the text file
    fileID = fopen(fileName, 'r');
    
    % Read the audio file name from the first line
    audioFileName = fgetl(fileID);
    
    % Initialize variables
    soundSegments = [];
    
    % Read the sound sequences until the line with symbols "--"
    tline = fgetl(fileID);
    while ~strcmp(tline, '--')
        % Read the start and end seconds from the current lines
        startSecond = str2double(fgetl(fileID));
        endSecond = str2double(fgetl(fileID));
        
        % Append the sound segment to the matrix
        soundSegments = [soundSegments, [startSecond; endSecond]];
        
        tline = fgetl(fileID);
    end
    
    % Close the text file
    fclose(fileID);
end