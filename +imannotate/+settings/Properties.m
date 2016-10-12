classdef Properties < handle
    %SETTINGS A SIGNLETON class that represents the project-wide settings
    %   Detailed explanation goes here
    
    properties(Constant)
        
        validShapes = { ...
            'point', 'imannotate.models.PointAnnotation'; ...
            'ellipse', 'imannotate.models.EllipseAnnotation'; ...
            'circle', 'imannotate.models.CircleAnnotation'; ...
            'line', 'imannotate.models.LineAnnotation'; ...
            'rectangle', 'imannotate.models.RectangleAnnotation'; ...
            'square', 'imannotate.models.SquareAnnotation'; ...
            'polygon', 'imannotate.models.PolygonAnnotation' ...
        };
    
    end
    
    properties(GetAccess=public, SetAccess = private)
        mode = 'interactive'; % interactive/project
        
        inputFolders = {}; % For projects only
        outputFolder = {}; % For projects only
        
        outputFormat = '.mat'; % .json, .mat, .csv, .. future support
        
        annotations = struct(); % contains infromation about the annotations        
    end
    
    methods(Static)
        
        % Returns a 1D cell array representing the valid shape names
        function shapeNames = validShapeNames()
            shapeNames = imannotate.settings.Properties.validShapes(:,1)';
        end

        % Returns a 1D cell array representing the valid shape classes
        function shapeClasses = validShapeClasses()
            shapeClasses = imannotate.settings.Properties.validShapes(:,2)';
        end
    
        % returns the shape name (e.g. 'circle') for a given
        % class name (e.g. imannotate.models.CircleAnnotation)
        function shapeName = validShapeName(shapeClass)
            classNames = imannotate.settings.Properties.validShapeClasses();
            shapeNames = imannotate.settings.Properties.validShapeNames();
            for i=1:length(classNames)
                if (strcmp(classNames{i}, shapeClass))
                    shapeName = shapeNames{i};
                    return;
                end
            end
            
            % Shape name not found
            ME = MException(imannotate.exceptions.illegalArgumentException(), 'The shape class does not exist.');
            throw(ME);            
        end
    
        % returns the class anem (e.g.
        % 'imannotate.models.CircleAnnotation') for a given shape name
        % (e.g. 'circle')
        function shapeClass = validShapeClass(shapeName)
            
            classNames = imannotate.settings.Properties.validShapeClasses();
            shapeNames = imannotate.settings.Properties.validShapeNames();
            for i=1:length(classNames)
                if (strcmp(shapeNames{i}, shapeName))
                    shapeClass = classNames{i};
                    return;
                end
            end
            
            % Shape class not found
            ME = MException(imannotate.exceptions.illegalArgumentException(), 'This shape name does not exist');
            throw(ME);            
        end

        function shapeNames = shapeClasses2names(shapeClasses)
           shapeNames = {};

           for j = 1:length(shapeClasses)
               shapeName = imannotate.settings.Properties.validShapeName(shapeClasses{j});
               shapeNames = [shapeNames {shapeName}];
           end
    
        end
        
        function shapeClasses = shapeNames2Classes(shapeNames)
           shapeClasses = {};

           for j = 1:length(shapeNames)
               shapeName = imannotate.settings.Properties.validShapeClass(shapeNames{j});
               shapeClasses = [shapeClasses {shapeName}];
           end
        end
        
        
        
    end
    
    methods

        function validateShapeClasses(self, shapeClasses)
            for i=1:length(shapeClasses)
                % So we search for the class to find the name and the
                % method will throw an error if the shape class was not
                % found (indirect "validation")
               shapeName = self.validShapeName(shapeClasses{i});
            end
            %             validateattributes(shapes, {'cell'}, {});
            %             validShapeNames = fieldnames(self.validateShapes);
            %             % validate shapes
            %             for i=1:length(shapes)
            %                 if (~ismember(shapes{i}, validShapeNames))
            %                     ME = MException( imannotate.exceptions.illegalArgumentException(), 'You have passed an unsupported shape' );
            %                     throw(ME);
            %                 end
            %             end           
        end
        
        function obj = Properties(varargin)
            
        end
        
        
        function setMode(self, mode)
            p = inputParser();
            addRequired(p, 'mode', @(x) validateattributes(x, {'interactive', 'project'}, {} ));
            parse(p, mode);
            
            self.mode = mode;
        end
        
        function addInputFolder(self, newFolder)
            p = inputParser();
            addRequired( p, 'newFolder', @(x) validateattributes(x, {'char'}, {}) );
            parse(p, newFolder);
            
            self.inputFolders = [self.inputFolders {newFolder}];
        end
        
        function addOutputFolder(self, newFolder)
            p = inputParser();
            addRequired( p, 'newFolder', @(x) validateattributes(x, {'char'}, {}) );
            parse(p, newFolder);
            
            self.outputFolders = [self.outputFolders {newFolder}];
        end
        
        function addAnnotation(self, id, shapes)
            p = inputParser();
            addRequired(p, 'id', @(x) validateattributes(x, {'char'}, {}));
            addRequired(p, 'shapes', @(x) self.validateShapeClasses(x));
            parse(p, id, shapes);
            
            % If everything went fine add the annotation to the set of
            % valid shapes
            self.annotations.(id) = shapes;
            
        end
        
    end
    
end
