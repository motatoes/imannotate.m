classdef SquareAnnotation < imannotate.models.Annotation
    %SQUAREANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        x;
        y;
        side;
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
        
        function obj = SquareAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)   
            setPosition@imannotate.models.Annotation(self, position);
            
            % [x, y, side]
            self.x = position(1);
            self.y = position(2);
            self.side = position(3);
        end
        
        function position = getPosition(self)
            position = [self.x, self.y, self.side];
        end
        
        function serialized = serialize(self)
            
        end
        
    end
    
end

