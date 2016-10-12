classdef AnnotationPropsLayout < handle
    %ANNOTATIONPROPSLAYOUT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
    end
    
    methods
        
        function obj = AnnotationPropsLayout(parentPanel, annotationProps)
            p = inputParser();
            addRequired(p, 'parentPanel', @(x) validateattributes(x, {'matlab.ui.container.Panel'}, {}));
            addRequired(p, 'annotationProps', @(x) validateattributes(x, {'struct'}, {}) );
            parse(p, parentPanel, annotationProps);
            
            u1 = uix.VBox('parent', parentPanel);
            obj.rebuildAnnotationOptions(u1, annotationProps);
            
        end
        
        function rebuildAnnotationOptions(self, parentContainer, annotationProps)
            % Parent container is usually a panel or a grid ...

            
            annotationNames = fieldnames(annotationProps);
            
            for i=1:length(annotationNames)
               annotationID = annotationNames{i};
               shapeClasses = annotationProps.(annotationID);
               if (isempty(shapeClasses)) 
                   continue; 
               end
               
               shapeNames = imannotate.settings.Properties.shapeClasses2names(shapeClasses);
               
               % We can now add the shape names to the GUI layout
                g1 = uix.Grid('parent', parentContainer);
                uib1 = uibuttongroup(g1, 'Title', annotationID);
                uib1v1 = uix.VBox('parent', uib1);
                for j=1:length(shapeNames)
                    uicontrol(uib1v1, 'Style', 'radiobutton', 'String', shapeNames{j});
                end
                uicontrol('string', ['Add ' annotationID], 'parent', g1);
               
            end
            
%             uib2v2 = uix.VBox('parent', uib2);
%             uicontrol (uib2v2, 'Style', 'radiobutton', 'String', 'radio 1');
%             uicontrol (uib2v2, 'Style', 'radiobutton', 'String', 'radio 2');
%             uicontrol('string', 'Add haemorage', 'parent', g2);
                        
        end
        
    end
    
end

