classdef PointAnnotation  < imannotate.models.Annotation
    %POINTANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        y;
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter
            if ( size(position,1) ~= 1 || size(position,2) ~= 2 )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was of the wrong size');
                throw(ME);
            end
        end
    end
    
    methods
        function obj = PointAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)
            setPosition@imannotate.models.Annotation(self, position);
            self.x = position(1);
            self.y = position(2);
        end
        
        function position = getPosition(self)
            position = [self.x, self.y];
        end
        
        function serialized = serialize(self)
        end
    end
    
end

