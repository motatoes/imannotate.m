classdef  MarkerCollection < handle
    %MARKERCOLLECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        % Stored references to handle objects of regions of interest
        % This be a struct of with a key for all the categories where the
        % key is the category label and the value is a vector of references
        % to the handle objects
        ROIhandles; % Stores references to various handle objects that are drawn
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
                    error('The label "categories" is reserved and cant be used, please chose another name');
                end
                self.ROIhandles.(label) = [];
            end
        end
        
        function setFigureHandle(self, newhandle)
            self.fighandle = newhandle;
        end
        
        function addMarker(self, label)
            % Select the right figure for the marker display
            figure(self.fighandle);
            
            % Find the categoy in our metadata to get all its info
            categoryFound = false;
            for i=1:length(self.categories)
                if (strcmp(self.categories(i).label, label))
                    idx = i;
                    categoryFound = true;
                    shape = self.categories(i).shape;
                    colour = self.categories(i).colour;    
                end
            end
            
            % Category not found :(  exit
            if (~categoryFound)
                error('A nonexistant category was passed as a parameter. Category passed: %s', label)
            end
            
            % Now that we have the sape, lets draw it on the plot and
            % get its handle
            tags =  self.categories(idx).tags;
            shapehndl = self.drawMarker(shape, 'colour', colour, 'tags', tags);
            
            % Append the handle to the right category location
            self.ROIhandles.(label) = [self.ROIhandles.(label) shapehndl];            
        end
        
        % This function displas markers from a 
        function loadMarkers(self, markerPositions)
            % Loop over all the categories
            for i=1:length(markerPositions.categories)
                % Get the category label name
                label = markerPositions.categories(i).label;
                
                % Get the shape and colour of this class
                shape = markerPositions.categories(i).shape;
                colour = markerPositions.categories(i).colour;
                tags = self.categories(i).tags;
%                 tags={};
                defaultTagStruct = self.getDefaultTagStruct(i);
                for j=1:length( markerPositions.(label).data )
                    % Get its position
                    pos = markerPositions.(label).data{j};
                    
                    % If the tags exist in that stored variable
                    if ( ismember('tags', fieldnames( markerPositions.(label)) ) ) 
                        tagstruct = markerPositions.(label).tags{j};
                    else
                        % Create a defaults tag struct with all zeros
                        tagstruct = defaultTagStruct;
                    end
                    
                    % Display the marker
                        h = self.drawMarker( shape, 'position', pos,'colour', colour, 'tags',  tags, 'tagstruct', tagstruct);
                    
                    % Append it to the internal list of handles
                    self.ROIhandles.(label) = [self.ROIhandles.(label) h];
                end
            end
        end
        
        function h=drawMarker(self, shape, varargin)
            p = inputParser;
            addParameter(p, 'colour', 'blue');
            addParameter(p, 'position', []);
            addParameter( p, 'tagstruct', struct() );
            parse(p, varargin{:})
            
            figure(self.fighandle);
            
            colour = p.Results.colour;
            position = p.Results.position;
            tagstruct = p.Results.tagstruct;
            
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
            % Make the object deletable
            hChildren = get(h, 'Children');
            hcmenu = get(hChildren(1),'UIContextMenu');
            delcallback = @(h2, a) delete(h);
            uimenu(hcmenu, 'Label', 'Delete', 'Callback', delcallback);
            
            % Add the tags menu callback
            tag_keys = fieldnames( tagstruct );
            if (length(tag_keys) > 0)
                tagscallback = @(menuhndl, a) self.setTags(menuhndl);
                tagsmenu = uimenu(hcmenu, 'Label',  'tags', 'Tag', 'tagsmenu');
                
                for i=1:length(tag_keys)
                    tag_key =  tag_keys{i};
                    chk = tagstruct.( tag_key );
                    if (chk == 1)
                        checked = 'on';
                    else
                        checked = 'off';
                    end
                    tm = uimenu(tagsmenu, 'Label', tag_key, 'Callback',  tagscallback, 'Checked', checked);
                    set(tm, 'Tag', tag_key);
                end
            end
            
        end
        
        function setTags(self, menuhndl)
%             tags = self.categories(idx).tags
            
            chk = get(menuhndl, 'checked');
            if (strcmp(chk, 'on'))
                % need to set it off and take action
                disp(' This menu is checked');
                set(menuhndl, 'checked', 'off');                
            elseif (strcmp(chk, 'off'))
                % Need to set it on and take action
                disp('This menu item is not checked');
                set(menuhndl', 'checked', 'on');
            end
            
        end
        
        function dtagstruct = getDefaultTagStruct(self, idx)
            taglist = self.categories(idx).tags;
            dtagstruct = struct();
            
            for i=1:length(taglist);
                dtagstruct.(taglist{i}) = 0;
            end
            
        end
        
        % Return the positions of all the markers (usually to store them)
        function res = serialize(self)
            % Get the size of the current image to save it in the
            % serialized object
            imageSize = size(getimage(self.fighandle));
            
            res = struct();
            res.categories = self.categories;
            res.imageSize = imageSize;
            
            for i=1:length(self.categories)
                
                label = self.categories(i).label;
                shape = self.categories(i).shape;
                colour = self.categories(i).colour;
                tag_names = self.categories(i).tags;
                
                ROItags = {};
                for  j = 1:length(self.ROIhandles.(label) )
                    tagvals = self.getTagsFromHandle( self.ROIhandles.(label)(j), tag_names );
                    ROItags{length(ROItags)+1} = tagvals; 
                end
                
                res.(label) = struct();
                res.(label).shape = shape;
                res.(label).colour = colour;
                res.(label).tags= ROItags;
                res.(label).data = self.handles2matrix( self.ROIhandles.(label) );
            end
        end
        
        function tagstruct = getTagsFromHandle(self, shp_hndl, tag_names)
            tagstruct = struct();
            
            count = 1;
            

            for i=1:length(tag_names)
                tagname = tag_names{i};
                if (isvalid(shp_hndl))

                    hChildren = get(shp_hndl, 'Children');
                    hcmenu = get(hChildren(1),'UIContextMenu');

                    tagmenu = findobj(hcmenu, 'tag', tagname);

                    if ( ~isempty(tagmenu) )
                        count = count + 1;
                        chk = get(tagmenu, 'checked');
                        if ( strcmp(chk, 'on') )
                            tagstruct.(tagname) = 1;
                        else
                            tagstruct.(tagname) = 0;
                        end
                    else
                        tagstruct.(tagname) = 0;
                    end
                else
                    tagstruct.(tagname) = 0;
                end
            end
            
        end
                
            
        % == loosely related functions ==%
        function data = handles2matrix(self, mat)
            data = {};
            if (~isa(mat, 'imroi') && length(mat)>0)
                error('Function called with wrong datatype %s, expected: %s', class(mat), 'imroi sublass')
            end
            
            count = 1;
            for i = 1:length(mat)
                h = mat(i);
                % Check if it wasn't deleted
                if (isvalid(h))
                    data{i} = h.getPosition();
                    count = count + 1;
                end
            end
        end
        
    end
    
end

