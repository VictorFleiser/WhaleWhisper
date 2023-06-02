function [soundData, soundName] = random_numbers(y, fs)
    % Generate 7 random numbers
    soundData = rand(1, 7);
    
    % Generate a random string for soundName
    characters = 'abcdefghijklmnopqrstuvwxyz';
    soundName = '';
    for i = 1:5
        soundName = [soundName, characters(randi(numel(characters)))];
    end
end