function [soundData, soundName] = tableauValeurNomDefaut(y, fs)
    soundData = repmat({'valeur'}, 1, 8);  % Use a cell array

    % Generate a random string for soundName
%    characters = 'abcdefghijklmnopqrstuvwxyz';
    soundName = 'Sound Name';
%    for i = 1:5
%        soundName = [soundName, characters(randi(numel(characters)))];
%    end
end