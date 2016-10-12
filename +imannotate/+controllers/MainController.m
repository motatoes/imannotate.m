classdef MainController < handle
    %MAINCONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        
        % The current state of settings
        settings;
        
        % A group of annotation collections
        annotations = {};
        
        % The main view dialog window
        mainView;
       
    end
    
    methods
        function obj = MainController(varargin)
            
            defaultProp = imannotate.settings.Properties();
            defaultProp.addAnnotation('Label', ...
                {
                  'imannotate.models.RectangleAnnotation', ...
                  'imannotate.models.EllipseAnnotation', ...
                  'imannotate.models.LineAnnotation', ...                 
                } ...
            );
            
            p = inputParser();
            addOptional(p, 'Properties', defaultProp.annotations);
            parse(p);
            
            obj.settings = p.Results.Properties;
            obj.mainView = imannotate.views.MainView(obj);
            
            obj.settings;
        end
        
    end
    
end
