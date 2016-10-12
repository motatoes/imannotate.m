classdef ImageViewerLayout < handle
    %IMAGEVIEWERLAYOUT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        panel;
        axes;
    end
    
    methods
        
        function obj = ImageViewerLayout(ImageViewerPanel)
            % Build the parent axis
            obj.panel = ImageViewerPanel;
            obj.axes = axes('parent', ImageViewerPanel);
            
            % Settings the axis colours to white in order to 'hide' them
            set(gca,'xcolor',get(obj.axes,'color'));
            set(gca,'ycolor',get(obj.axes,'color'));
            % hiding the x amd y ticks
            set(obj.axes,'xtick',[])
            set(obj.axes,'ytick',[])
        end

        
        % Callbacks etc.
        function openImage(self, varargin)
            [filename, path, filterIndex] = uigetfile( ...
                {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
                 '*.*','All Files' }, 'Select an image', ...
                 '.\');
             
             % Do not continue if the user clicked cancel
             if (filterIndex ~= 0)
                img = imread([path, filename]);

                % Select the current figure and axes
%                 figure(self.mainFigure);
                axes(self.axes);

                % Show the image in the image viewer window
                imshow(img);
             end
        end
                
        
    end
    
end

