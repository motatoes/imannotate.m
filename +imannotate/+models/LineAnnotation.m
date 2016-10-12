classdef LineAnnotation < imannotate.models.Annotation
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x1;
        y1;
        x2;
        y2;
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter
            if ( size(position,1) ~= 2 || size(position,2) ~= 2 )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was of the wrong size');
                throw(ME);
            end
        end
    end
    
    
    methods
        function obj = LineAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)            
            setPosition@imannotate.models.Annotation(self, position);
            
            self.x1 = position(1,1);
            self.y1 = position(1,2);
            self.x2 = position(2,1);
            self.y2= position(2,2);
        end
        
        function position = getPosition(self)
            position = [self.x1, self.y1; self.x2, self.y2];
        end
        
        function serialized = serialize(self)
        end
        
    end
    
end

