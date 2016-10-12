classdef ImageFiltersLayout < handle
    %IMAGEFILTERSLAYOUT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = ImageFiltersLayout(parentPanel)
            u1 = uix.VBox('parent', parentPanel);
            
            ub1 = uibuttongroup(u1, 'title', 'brightness');
            ub2 = uibuttongroup(u1, 'title', 'contrast');
    
            ub1x1 = uix.VBox('parent', ub1, 'padding', 5);
            ub2x2 = uix.VBox('parent', ub2, 'padding', 5);
            
            uicontrol('parent', ub1x1, 'style', 'slider');
            uicontrol('parent', ub2x2, 'style', 'slider');
            uicontrol('style', 'pushbutton', 'parent', u1, 'String', 'Reset');
        end
    end
    
end

