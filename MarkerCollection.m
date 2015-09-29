classdef  MarkerCollection < handle
    %MARKERCOLLECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        % Stored references to handle objects of regions of interest
        % This be a struct of with a key for all the categories where the
        % key is the category label and the value is a vector of references
        % to the handle objects
        ROIhandles;
        categories; % Struct array defines the categories and their respective props
        fighandle; % The figure handle
    end
        
    methods
        % == Constructor == % 
        function obj = MarkerCollection(categories, hndl)
            obj.fighandle = hndl;
            obj.categories = categories;
            obj.ROIhandles = struct();
            
            % Reset the markers to defaults
            obj.reset()
        end    
        
        function reset(self)
            categories = self.categories;

            for i=1:length(categories)
                label = categories(i).label;
                
                if strcmp(label, 'categories')
                    error('The label "categories" is reserved and cant be used, please chose another name')
                end
                self.ROIhandles.(label) = [];
            end
            
        end
        
        function setFigureHandle(self, newhandle)
            self.fighandle = newhandle;
        end
        
        function addMarker(self, category)
            
            % Select the right figure for the marker display
            figure(self.fighandle);
            
            % Find the categoy in our metadata to get all its info
            categoryFound = false;
            for i=1:length(self.categories)
                if (strcmp(self.categories(i).label, category))
                    categoryFound = true;
                    shape = self.categories(i).shape;
                    colour = self.categories(i).colour;    
                end
            end
            
            % Category not found :(  exit
            if (~categoryFound)
                error('A nonexistant category was passed as a parameter. Category passed: %s', category)
            end

            % Now that we have the sape, lets draw it on the plot and
            % get its handle
            h = self.drawMarker(shape, 'colour', colour);
            
            % Append the handle to the right category location
            self.ROIhandles.(category) = [self.ROIhandles.(category) h];
        end

        % This function displas markers from a 
        function loadMarkers(self, markerPositions)
            % Loop over allt he categories
            for i=1:length(markerPositions.categories)
                
                % Get the category label name
                category = markerPositions.categories(i).label;
                
                % Get the shape and colour of this class
                shape = markerPositions.categories(i).shape;
                colour = markerPositions.categories(i).colour;
                
                for j=1:length(markerPositions.(category).data)
                    % Get its position
                    pos = markerPositions.(category).data{j};
                    
                    % Display the marker
                    h = self.drawMarker( shape, 'position', pos,'colour', colour);
                    
                    % Append it to the internal list of handles
                    self.ROIhandles.(category) = [self.ROIhandles.(category) h];
                end
            end
        end
        
        function h=drawMarker(self, shape, varargin)
            p = inputParser;
            addParameter(p, 'colour', 'blue');
            addParameter(p, 'position', [])
            parse(p, varargin{:})
            
            figure(self.fighandle);
            
            colour = p.Results.colour;
            position = p.Results.position;
            
            if ( strcmp(shape, 'rectangle') )
                h = imrect(gca, position);
            elseif ( strcmp(shape, 'ellipse') )
                h = imellipse(gca, position);
            elseif ( strcmp(shape, 'line') )
                h = imline(self.fighandle);
            elseif ( strcmp(shape, 'point') )
                h = impoint(gca, position);
            elseif ( strcmp(shape, 'polygon') )
                h = impoly(gca, position);
            end
            
            % The shape we got is not valid :( Exit
            if (~exist('h', 'var'))
                error( 'Error: addMarker() called with invalid shape: "%s\"', shape );
            end
            
            % Set the colour
            h.setColor(colour);
        end
        
        % Return the positions of all the markers (usually to store them)
        function res = serialize(self)
            res = struct();
            res.categories = self.categories;
            
            for i=1:length(self.categories)
                label = self.categories(i).label;
                shape = self.categories(i).shape;
                colour = self.categories(i).colour;
                
                res.(label) = struct();
                res.(label).shape = shape;
                res.(label).colour = colour;
                res.(label).data = self.handles2matrix( self.ROIhandles.(label) );
            end
        end
        
        
        % == loosely related functions ==%
        function data = handles2matrix(self, mat)
            data = {};
            if (~isa(mat, 'imroi') && length(mat)>0)
                error('Function called with wrong datatype %s, expected: %s', class(mat), 'imroi sublass')
            end
            
            for i = 1:length(mat)
                h = mat(i);
                % Check if it wasn't deleted
                if (isvalid(h))
                    data{i} = h.getPosition();
                end
            end
        end
        
    end
    
end

