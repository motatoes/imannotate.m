classdef MainView < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        controller; % The main controller object
        
        % views
        mainFigure;
        
        % Layouts
        imageViewerLayout; % for the image viewer
        annotationPropsLayout;
        imageFiltersLayout;
        batchLayout;
        
        settingsModal;
    end
    
    methods
        function obj = MainView(mainController)
            p = inputParser();
            addRequired(p, 'mainController', @(x) validateattributes(x, {'imannotate.controllers.MainController'}, {}));
            parse(p, mainController);
            obj.controller = mainController;
            
            obj.buildGUI();
            
            % Add the property listeners here ...
            
        end
        
        function buildGUI(self)
            
            self.mainFigure = figure;
            
            % Construct the figure menus
            self.buildFigureMenus();
            
            mainHbox = uix.VBoxFlex('parent', self.mainFigure);
            
            % building the toolbar layout
            toolbarGrid = uix.GridFlex('Parent', mainHbox, 'spacing', 3, 'padding', 3);
            self.buildToolbarPanels(toolbarGrid);
            
            % Building the Image Viewer Layout            
            ImageViewerPanel = uipanel('parent', mainHbox, 'Title', 'Image Viewer');
            self.imageViewerLayout = imannotate.views.ImageViewerLayout(ImageViewerPanel);
            
            % Setting the window positions
            set(self.mainFigure, 'units', 'normalized');
            set(self.mainFigure, 'outerPosition', [0.01, 0.05, 0.97, 0.9]);
            
            set(mainHbox, 'heights', [150 -1]);
            
        end

        function buildToolbarPanels(self, parentGrid)
            AnnotationsPanel = uipanel('Parent', parentGrid, 'Title', 'Annotations');
            ImageFiltersPanel = uipanel('Parent', parentGrid, 'Title', 'Image filters');
%             BatchLayoutPanel = uipanel('Parent', parentGrid, 'Title', 'Batch Mode');
            
            self.annotationPropsLayout = imannotate.views.AnnotationPropsLayout( AnnotationsPanel, self.controller.settings );
            self.imageFiltersLayout = imannotate.views.ImageFiltersLayout(ImageFiltersPanel);
%             self.batchLayout = imannotate.views.BatchLayout(BatchLayoutPanel);
        end
        
        function buildFigureMenus(self)
            % Remove the main figure's menu and toolbar
            set(self.mainFigure, 'menubar', 'none');
            
            um1 = uimenu(self.mainFigure, 'Label', 'File');
            uimenu(um1, 'Label', 'Open', 'Accelerator', 'o', ...
                'callback', @(varargin) self.imageViewerLayout.openImage());
            uimenu(um1, 'Label', 'Save', 'Accelerator', 's');
            uimenu(um1, 'Label', 'Load markers', 'Accelerator', 'L');
            uimenu(um1, 'Label', 'Settings');
            uimenu(um1, 'Label', 'Exit', 'Accelerator', 'q');
        end
        
        function resetToolbarPanel(self)
            
        end
        
        
        % Stack the main windows to fill the screen
        function stackMainWindow(self)
            
        end
        
        
    end
    
end

