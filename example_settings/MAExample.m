classdef MAExample < handle
    
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
        function obj = MAExample(self)

        MA_tags ={'subtle', 'regular', 'obvious', 'close_to_vessel'};
            
        obj.CATEGORIES = [ ...
                struct('label', 'microaneurysm', 'shape', 'circle', 'colour', 'blue', 'tags', {MA_tags} ) ...
            %     struct('label', 'exudate', 'shape', 'rectangle', 'colour', 'white'), ...
            %     struct('label', 'irma', 'shape', 'polygon', 'colour', 'green'), ...
            %     struct('label', 'newvessel', 'shape', 'rectangle', 'colour', 'black'), ...
            %     struct('label', 'artefact', 'shape', 'rectangle', 'colour', [1 0.5 0]), ...
            %     struct('label', 'cottonwool', 'shape', 'rectangle', 'colour', 'yellow'), ...
        ];

        end
    end
end