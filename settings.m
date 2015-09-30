
% Set some inital variables

% The main settings variable is a struct
SETTINGS = struct();

% == SETTINGS.CATEGORIES ==
% An array containing details about the types of annotation markers that
% are persent. We also define the shape and colour of each annotation
% Possible shapes: [rectangle, ellipse, polygon, line, point]
SETTINGS.CATEGORIES = [
    struct('label', 'CLASS1', 'shape', 'ellipse', 'colour', 'blue'), ...
    struct('label', 'CLASS2', 'shape', 'rectangle', 'colour', 'white'), ...
    struct('label', 'CLASS3', 'shape', 'polygon', 'colour', 'green'), ...
    struct('label', 'CLASS4', 'shape', 'rectangle', 'colour', 'black'), ...
    struct('label', 'CLASS5', 'shape', 'rectangle', 'colour', [1 0.5 0]), ...
    struct('label', 'CLASS6', 'shape', 'rectangle', 'colour', 'yellow'), ...
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
SETTINGS.MARKERS_FILE_SUFFX = '_markers_new.mat';

