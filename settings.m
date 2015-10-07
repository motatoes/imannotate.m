% Set some inital variables

% The main settings variable is a struct
SETTINGS = struct();

% == SETTINGS.CATEGORIES ==
% An array containing details about the types of annotation markers that
% are persent. We also define the shape and colour of each annotation
% Possible shapes: [rectangle, ellipse, polygon, line, point]
% = Tags are some extra information about the label: example if you have cars
% your tags could be: Sports Car, Truck, ....
% Spaces are not allowed in tag names
% you can select one or more tags together
SETTINGS.CATEGORIES = [
    struct('label', 'CLASS1', 'shape', 'ellipse', 'colour', 'blue', 'tags', {{}}), ...
    struct('label', 'CLASS2', 'shape', 'rectangle', 'colour', 'white', 'tags', {{'tag1', 'tag2'}}), ...
    struct('label', 'CLASS3', 'shape', 'polygon', 'colour', 'green', 'tags', {{}}), ...
    struct('label', 'CLASS4', 'shape', 'rectangle', 'colour', 'black', 'tags', {{'tag1', 'tag2', 'tag3'}}), ...
    struct('label', 'CLASS5', 'shape', 'rectangle', 'colour', [1 0.5 0], 'tags', {{}}), ...
    struct('label', 'CLASS6', 'shape', 'rectangle', 'colour', 'yellow', 'tags', {{'tag1', 'tag2'}}), ...
];

% == SETTINGS.START_PATH ==
% Initial location when the application starts (leave empty to start from
% current working directory
SETTINGS.START_PATH = '';

% == SETTINGS.MARKERS_PATH ==
% The folder location where al the marker paths are stored
SETTINGS.MARKERS_PATH = 'PATH/TO/WHERE/MARKER/MAT/FILES/WILL/BE/STORED/';

% == SETTINGS.MARKERS_FILE_SUFFIX ==
% The prefix for all the marker data (mat files)
SETTINGS.MARKERS_FILE_SUFFIX = '_markers_new.mat';