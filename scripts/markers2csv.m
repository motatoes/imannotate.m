% A Script that takes as input a folder containing matfiles that are
% produced by imannotate software and outputs a csv file that represnets
% all the datapoints that result from this data point.

INPUT_FOLDER = uigetdir('', 'Select the input folder')

OUTPUT_FOLDER = uigetdir('', 'Select the output folder')

matfiles = ls([INPUT_FOLDER, '*.mat']);

for i=1:size(matfiles,1)
    result = {'X', 'Y', 'radius', 'obvious', 'regular', 'subtle', 'close_to_vessel'};
    
    matfile = matfiles(i,:);
    
    [~, imgnamenoext, ~] = fileparts(['.\',  matfile]);
    
    x = load([INPUT_FOLDER '/' matfile]);
    markerPositions = x.markerPositions;
    
    categories = markerPositions.categories.label;
    
    for j=1:size(categories,1)
        category = categories(j, :);
        
        datapoints = markerPositions.(category).data;
        shape = markerPositions.(category).shape;
        for k = 1:length(datapoints)
            datapoint = datapoints{k};
            tag_ctv = markerPositions.(category).tags{k}.close_to_vessel;
            tag_obvious = markerPositions.(category).tags{k}.obvious;
            tag_regular = markerPositions.(category).tags{k}.subtle;
            tag_subtle = markerPositions.(category).tags{k}.regular;
            result = [result; {datapoint(1), datapoint(2), datapoint(3), tag_obvious, tag_regular, tag_subtle, tag_ctv }];
        end
    end
    
    cell2csv([OUTPUT_FOLDER, imgnamenoext, '.csv'], result, ',');
    
end

