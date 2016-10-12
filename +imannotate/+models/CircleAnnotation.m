classdef CircleAnnotation < imannotate.models.Annotation
    %CIRCLEANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        x
        y
        radius
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter
            if ( size(position,1) ~= 1 || size(position,2) ~= 3 )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was of the wrong size');
                throw(ME);
            end
        end
    end
    
    
    methods
        
        function obj = CircleAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)
            setPosition@imannotate.models.Annotation(self, position);
            
            self.x = position(1);
            self.y = position(2);
            self.radius = position(3);           
        end
        
        function position = getPosition(self)
            position = [self.x, self.y, self.radius];
        end
        
        function serialized = serialize(self)
        end
        
    end
    
end

