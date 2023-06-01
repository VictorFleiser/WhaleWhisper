function gui(whale_found, spectrogramData, end_second, y, fs, tableData, columnNames)
    
    % Teste quel baleine à aficher
    % Valeurs possibles :
    %"Baleine à Bosse", "Baleine Bleue", "Baleine Boréale", "Rorqual commun"
    if     (whale_found == "Baleine a Bosse")
        imageData = imread('Baleine_a_Bosse.jpg');
    elseif (whale_found == "Baleine Bleue")
        imageData = imread('Baleine_Bleue.jpg');
    elseif (whale_found == "Baleine Boréale")
        imageData = imread('Baleine_Boreale.jpg');
    elseif (whale_found == "Rorqual commun")
        imageData = imread('Rorqual_Commun.jpg');
    else %Baleine par default
        imageData = imread('Baleine_a_Bosse.jpg');
    end

    figure('Name', 'Image Analysis', 'Position', [100, 100, 800, 600]);

    % Display the image
    subplot(2, 2, 1);
    imshow(imageData);
    
    % Display the spectrogram                   % A CHANGER
    subplot(2, 2, 2);
    spectrogramData = abs(spectrogramData);  % Ensure the spectrogram data is non-negative
    
    % Calculate the time and frequency axes
    time_axis = linspace(0, end_second, size(spectrogramData, 2));
    frequency_axis = linspace(0, fs/2, size(spectrogramData, 1));
    
    % Display the spectrogram with correct orientation and axis labels
    imagesc(time_axis, frequency_axis, 10*log10(spectrogramData));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar();
%      % Manually add the label using a text object
%      colorbar_label = text(1.2, 0.5, 'Power/frequency (dB/Hz)', 'Rotation', -90, ...
%          'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Units', 'normalized');

    title('Spectrogram');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    
    
    % Create row names for the table
    rowNames = {'Son', 'Durée (sec)', 'Fréquence fondamentale (Hz)', 'Fréq minimum (Hz)', ...
        'Fréq maximum (Hz)', 'Fréq début (Hz)', 'Fréq fin (Hz)', 'Intervalle de fréquences'};
    
    % Display the table

    % Calculate the position and size of the table relative to the window size
    tablePosX = 0.05;
    tablePosY = 0.05;
    tableWidth = 0.9;
    tableHeight = 0.4;
    
    % Transpose the tableData
    tableData = tableData';

    % Display the table
    dataTable = uitable('Data', tableData, 'ColumnName', columnNames, 'RowName', rowNames);
    set(dataTable, 'Units', 'normalized', 'Position', [tablePosX, tablePosY, tableWidth, tableHeight]);
end