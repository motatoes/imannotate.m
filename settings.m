
% Set some inital variables
SETTINGS = struct();
% Possible shapes: [rectangle, ellipse, polygon, line, point]
SETTINGS.CATEGORIES = [
    struct('label', 'microaneurysm', 'shape', 'ellipse', 'colour', 'blue'), ...
%     struct('label', 'exudate', 'shape', 'rectangle', 'colour', 'white'), ...
%     struct('label', 'irma', 'shape', 'polygon', 'colour', 'green'), ...
%     struct('label', 'newvessel', 'shape', 'rectangle', 'colour', 'black'), ...
%     struct('label', 'artefact', 'shape', 'rectangle', 'colour', [1 0.5 0]), ...
%     struct('label', 'cottonwool', 'shape', 'rectangle', 'colour', 'yellow'), ...
];


SETTINGS.START_PATH = '';
SETTINGS.MARKERS_PATH = 'F:\Dropbox\Dropbox (sand)\phd\kingston\fundus_datasets\longitudinal_images-col-15-01-15\markers_fullsize';

% The prefix for all the marker variables
SETTINGS.MARKERS_FILE_PREFIX = '_markers_new.mat';

