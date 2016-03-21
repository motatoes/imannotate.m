function [ varargout ] = serializedObj2binaryMask( serializedObj, varargin )
%SERIALIZEDOBJ2BINARYMASK Converts a serialized object from the GUI to a
%binary mask where the locations of the ROIs are 1 and the rest of the
% image is zeros
%  * serializedObj: The object that was stored by the GUI interface (usually
%   loaded by the load function 'getSerializedObject')
%  * labels: A
% *scaleratio: parameter that controls how scaled the MA objects are
% (default=1)
% *outputsize: parameter that controls the output size of the resulting
% image
    
    categories = serializedObj.categories;
    imsize = serializedObj.imageSize;
    
    p = inputParser();
    addParameter( p, 'scaleratio',1);
    addParameter( p, 'outputsize', imsize);
    addParameter( p, 'labelFilter', {categories.label} );
    addParameter( p, 'tagsFilter', struct() );
    
    parse(p, varargin{:});
    scaleratio = p.Results.scaleratio;
    outputsize = p.Results.outputsize;
    labelsFilter = p.Results.labelFilter;
    tagsFilter = p.Results.tagsFilter;
    
    resmask = zeros( [outputsize(1), outputsize(2)] ) ;
    % Initialize cell array
    cellarr = struct();
    
    for i = 1:length(categories)
        label = categories(i).label;
        
        if ( ismember(label, labelsFilter))
            shape = categories(i).shape;
            data = serializedObj.(label).data;
            tags = serializedObj.(label).tags;
            
            if ( ismember(label, fieldnames(tagsFilter) ) )
                data = filterData( data, tags, tagsFilter.(label) );
            end
            

            % Get the cell array and the mask
            [mask, CA] = dataExtract( data, shape, outputsize, scaleratio );
            % append the results of this iteration
            resmask(mask) = i;
            cellarr.(label) = CA;
        end        
    end
    
    
    if (nargout==1)
        varargout{1} = resmask;
    elseif (nargout ==2)
        varargout{1} = resmask;
        varargout{2} = cellarr;
    end
    
    
    function [mask, cellarray] = dataExtract(data, shape, outsize, scaleratio)
        
        % Create an invisible figure to draw shapes and get corresponding
        % masks
        hndl = figure('visible', 'off');
        
        resMask = false( [outsize(1), outsize(2)] );
        resCellArray = {};
        
        for i=1:length(data)
            
            % Display an empty image on the hidden figure
            tmp = false([outsize(1), outsize(2)]);
            im_hndl = imshow(tmp);
            
            position = data{i}*scaleratio;
            
            % Draw the shape on the figure
            shp = drawShape(hndl, shape, position);
            BW = createMask(shp, im_hndl);
            
            % Get the corresponding mask
            resMask=  resMask | BW;
            resCellArray{i} = find(BW);
        end
        
        mask = resMask;
        cellarray = resCellArray;
        % Close the invisible figure
        close(hndl);
        
        
    function shp = drawShape(hndl, shape, position)
        
        % Set the current figure
        set( 0, 'currentfigure', hndl );  %# for figures
        
        if ( strcmp(shape, 'rectangle') )
            shp = imrect(gca, position);
        elseif ( strcmp(shape, 'ellipse') )
            shp = imellipse(gca, round(position));
        elseif ( strcmp(shape, 'circle') ) % A circle is just an ellipse with radius1=radius2 and this is assumed to be handeled in the GUI interface etc.
            shp = imellipse(gca, round(position));
        elseif ( strcmp(shape, 'line') )
            shp = imline(self.fighandle);
        elseif ( strcmp(shape, 'point') )
            shp = impoint(gca, position);
        elseif ( strcmp(shape, 'polygon') )
            shp = impoly(gca, position);
        end
    


        function tagstruct = categories2tagstruct( categories )
            tagstruct = struct();
            labels = { categories.label };
            
            for i =1:length(labels)
                tagstruct.( labels{i} ) = categories.( labels(i) ).tags;
            end
            
            
        function filteredData =  filterData( data, tags, tagsCatFilter )
            
            % Labels in the tags struct
            filteredData = {};
            for i = 1:length(tags)
                tagstruct = tags{i};
                
                for j=1:length(tagsCatFilter)
                    taglabel = tagsCatFilter{j};
                    if ( tagstruct.( taglabel ) == 1 )
                        filteredData{ length(filteredData)+1 } = data{i} ;
                        break;
                    end
                end
                
            end
            
            
            