function gui(whale_found, spectrogramData, soundSegments, fs, tableData, columnNames, list_y)

    % Teste quel baleine à aficher
    % Valeurs possibles :
    %"Baleine a Bosse", "Baleine Bleue", "Baleine Boréale", "Rorqual commun"
    if     (whale_found == "Baleine a Bosse")
        imageData = imread('Baleine_a_Bosse.jpg');
        whaleFoundString = "Baleine a Bosse trouvée";
    elseif (whale_found == "Baleine Bleue")
        imageData = imread('Baleine_Bleue.jpg');
        whaleFoundString = "Baleine Bleue trouvée";
    elseif (whale_found == "Baleine Boréale")
        imageData = imread('Baleine_Boreale.jpg');
        whaleFoundString = "Baleine Boréale trouvée";
    elseif (whale_found == "Rorqual commun")
        imageData = imread('Rorqual_Commun.jpg');
        whaleFoundString = "Rorqual commun trouvé";
    else %Baleine par default
        imageData = imread('Baleine_a_Bosse.jpg');
        whaleFoundString = "Pas de baleine trouvée passée en paramètre de gui()";
    end

    figure('Name', 'WhaleWhisper', 'Position', [100, 100, 800, 600]);

    % Display the image
    subplot(2, 2, 1);
    imshow(imageData);
    
    % Add the title under the image
    titleAxes = axes('Position', [0, 0.45, 0.5, 0.9]);
    set(titleAxes, 'Visible', 'off');
    text(0.5, 0.1, whaleFoundString, 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');

    % Initialize the spectrogram axes
    spectrogramAxes = subplot(2, 2, 2);
    spectrogramData{1} = abs(spectrogramData{1});  % Ensure the spectrogram data is non-negative
    
    % Calculate the time and frequency axes
    time_axis = linspace(soundSegments(1, 1), soundSegments(2, 1), size(spectrogramData{1}, 2));
    frequency_axis = linspace(0, fs{1}/2, size(spectrogramData{1}, 1));
    
    % Display the initial spectrogram
    imagesc(spectrogramAxes, time_axis, frequency_axis, 10*log10(spectrogramData{1}));
    set(gca, 'YDir', 'normal');
    colormap(jet);
    colorbar();
    title('Spectrogram');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');

    
    % Create row names for the table
    rowNames = {'Durée (sec)', 'Fréq minimum (Hz)', 'Fréq maximum (Hz)', 'Fréq début (Hz)', 'Fréq fin (Hz)', 'Fréq moyenne (Hz)', 'Equart Max-Min'};
    
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
% Set the callback function for table cell selection
    set(dataTable, 'CellSelectionCallback', @(src, event) updateSpectrogram(src, event, spectrogramAxes, spectrogramData, soundSegments, fs, columnNames, list_y));
end

% Callback function to update the spectrogram based on the selected sound
function updateSpectrogram(~ , event, spectrogramAxes, spectrogramData, soundSegments, fs, columnNames, list_y)
    % Get the selected row and column indices
    selectedRows = event.Indices(:, 1);
    selectedColumns = event.Indices(:, 2);
    
    % Check if a single cell is selected
    if numel(selectedRows) == 1 && numel(selectedColumns) == 1
        % Get the spectrogram data for the selected sound
        selectedSpectrogram = spectrogramData{selectedColumns};
        
        % Calculate the time and frequency axes
        time_axis = linspace(soundSegments(1, selectedColumns), soundSegments(2, selectedColumns), size(selectedSpectrogram, 2));
        frequency_axis = linspace(0, fs{selectedColumns}/2, size(selectedSpectrogram, 1));
        
        % Take the magnitude of the spectrogram data
        magnitudeSpectrogram = abs(selectedSpectrogram);

         % Update the spectrogram display
        imagesc(spectrogramAxes, time_axis, frequency_axis, 10*log10(magnitudeSpectrogram));
        set(gca, 'YDir', 'normal');
        colormap(jet);
        colorbar();

        % Update the title
        selectedSound = columnNames{selectedColumns};
        title(['Spectrogram: ' selectedSound]);

        xlabel('Time (s)');
        ylabel('Frequency (Hz)');

        % Get the corresponding sound segment
        selectedSoundSegment = list_y{selectedColumns};
            
        % Play the sound segment
        soundsc(selectedSoundSegment, fs{selectedColumns});
    end
end