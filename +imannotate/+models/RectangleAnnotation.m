classdef RectangleAnnotation < imannotate.models.Annotation
    %RECTANGLEANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        x;
        y;
        height;
        width;
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter
            if ( size(position,1) ~= 1 || size(position,2) ~= 4 )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was of the wrong size');
                throw(ME);
            end
        end
    end
    
    methods
        
        function obj = RectangleAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)
            setPosition@imannotate.models.Annotation(self, position);
            
            self.x = position(1);
            self.y = position(2);
            self.width = position(3);
            self.height = position(4);
        end
        
        function position = getPosition(self)
            position = [self.x, self.y, self.width, self.height];
        end
        
        function serialized = serialize(self)
        end
        
    end
    
end

