% A Script that takes as input a folder containing matfiles that are
% produced by imannotate software and outputs a csv file that represnets
% all the datapoints that result from this data point.

INPUT_FOLDER = '';
OUTPUT_FOLDER = '';
INPUT_FOLDER = 'E:\phd\kingston\fundus_datasets\Messidor_Habib\groundtruth\MA\markers\';
OUTPUT_FOLDER = 'E:\phd\kingston\fundus_datasets\Messidor_Habib\groundtruth\MA\csv\';


matfiles = ls([INPUT_FOLDER, '*.mat']);

for i=1:size(matfiles,1)
    result = {'category', 'shape', 'datapoint'};
    
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
            result = [result; {category, shape, datapoint}];
        end
    end
    
    cell2csv([OUTPUT_FOLDER, imgnamenoext, '.csv'], result, ',');
    
end

