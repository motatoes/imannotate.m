function [ varargout ] = serializedObj2binaryMask( serializedObj )
%SERIALIZEDOBJ2BINARYMASK Converts a serialized object from the GUI to a
%binary mask where the locations of the ROIs are 1 and the rest of the
% image is zeros
%  * serializedObj: The object that was stored by the GUI interface (usually
%   loaded by the load function 'getSerializedObject')
%  * labels: A
    categories = serializedObj.categories;
    size = serializedObj.imageSize;
    resmask = zeros( [size(1), size(2)] ) ;
    for i=1:length(categories)
        label = categories(i).label;
        shape = categories(i).shape;
        data = serializedObj.(label).data;
        
        [mask, cellarr] = dataExtract( data, shape, size );
        resmask(mask) = i;
        
    end
    
    
    if (nargout==1)
        varargout{1} = resmask;
    elseif (nargout ==2)
        varargout{1} = resmask;
        varargout{2} = cellarr;
    end
        

    function [mask, cellarray] = dataExtract(data, shape, imsize)
        
        % Create an invisible figure to draw shapes and get corresponding
        % masks
        hndl = figure('visible', 'off');
        
        resMask = false( [imsize(1), imsize(2)] );
        resCellArray = {};
        
        for i=1:length(data)
            
            % Display an empty image on the hidden figure
            tmp = false([imsize(1), imsize(2)]);
            im_hndl = imshow(tmp);
            
            position = data{i};
            
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
        set(0, 'currentfigure', hndl);  %# for figures


        if ( strcmp(shape, 'rectangle') )
            shp = imrect(gca, position);
        elseif ( strcmp(shape, 'ellipse') )
            shp = imellipse(gca, position);
        elseif ( strcmp(shape, 'line') )
            shp = imline(self.fighandle);
        elseif ( strcmp(shape, 'point') )
            shp = impoint(gca, position);
        elseif ( strcmp(shape, 'polygon') )
            shp = impoly(gca, position);
        end
        
      

            
            