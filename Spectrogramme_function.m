function [spectrogramData, y, fs] = Spectrogramme_function(file_name, start_second, end_second)
    [y, fs] = audioread(file_name);
    start_index = round(start_second * fs);
    end_index = round(end_second * fs);    
    segment = y(start_index:end_index);
    [spectrogramData, ~, ~, ~] = spectrogram(segment, hann(1024), 512, 1024, fs, 'yaxis');
end