function [soundData, soundName] = random_numbers(y, fs)
    % Generate 8 random numbers
    soundData = rand(1, 8);
    
    % Generate a random string for soundName
    characters = 'abcdefghijklmnopqrstuvwxyz';
    soundName = '';
    for i = 1:5
        soundName = [soundName, characters(randi(numel(characters)))];
    end
end