classdef SquaresExample < handle
    
% Set some inital variables
    properties(Constant)
        
        START_PATH = '';
        
        % Where to store the markers (current path by default)
        MARKERS_PATH = '.';

        % The prefix to add to the marker .mat files
        MARKERS_FILE_SUFFIX = '_markers.mat';

    end
    
    properties(SetAccess=private)
        CATEGORIES;
    end
    
    methods
        function obj = SquaresExample(self)

            obj.CATEGORIES = [
%                 struct('label', 'CLASS0', 'shape', 'circle', 'colour', [1 1 1], 'tags', {{}}), ...
%                 struct('label', 'CLASS1', 'shape', 'ellipse', 'colour', 'blue', 'tags', {{}}), ...
                struct('label', 'CLASS2', 'shape', 'rectangle', 'colour', 'white', 'tags', {{'tag1', 'tag2'}}), ...
%                 struct('label', 'CLASS3', 'shape', 'polygon', 'colour', 'green', 'tags', {{}}), ...
%                 struct('label', 'CLASS4', 'shape', 'rectangle', 'colour', 'black', 'tags', {{'tag1', 'tag2', 'tag3'}}), ...
%                 struct('label', 'CLASS5', 'shape', 'line', 'colour', [1 0.5 0], 'tags', {{}}), ...
%                 struct('label', 'CLASS6', 'shape', 'point', 'colour', 'yellow', 'tags', {{'tag1', 'tag2'}}), ...
            ];

        end
    end
end
