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
    addParameter(p, 'scaleratio',1);
    addParameter(p, 'outputsize', imsize);
    parse(p, varargin{:});
    scaleratio = p.Results.scaleratio;
    outputsize = p.Results.outputsize;
    
    resmask = zeros( [outputsize(1), outputsize(2)] ) ;
    for i=1:length(categories)
        label = categories(i).label;
        shape = categories(i).shape;
        data = serializedObj.(label).data;
        
        [mask, cellarr] = dataExtract( data, shape, outputsize, scaleratio );
        resmask(mask) = i;
        
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
        
      

            
            