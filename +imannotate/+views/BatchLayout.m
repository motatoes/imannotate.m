classdef BatchLayout < handle
    %BATCHLAYOUT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = BatchLayout(parentPanel)
            
            u1 = uix.VBox('parent', parentPanel);
            
            uicontrol('style', 'text', 'parent', u1, 'string', 'Input folder: xxx');
            uicontrol('style', 'listbox', 'parent', u1);
            uicontrol('style', 'pushbutton', 'parent', u1, 'string', 'Save image');
            
            set(u1, 'heights', [20 -1 30]);
        end
    end
    
end

