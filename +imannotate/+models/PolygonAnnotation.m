classdef PolygonAnnotation < imannotate.models.Annotation
    %POLYGONANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        % Note that x and y refer to a group of points in this case
        x;
        y;
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter
            if ( size(position,1) ~= 2 || size(position,2) <= 0 )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was not the right size. Expected: 2xn');
                throw(ME);
            end
        end
    end
    
    
    methods
        
        function obj = PolygonAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)
            setPosition@imannotate.models.Annotation(self, position);
            
            % [x1, x2 ... xn; y1, y2 ... yn ]
            self.x = position(1, :);
            self.y = position(2, :);
        end
        
        function position = getPosition(self)
            position = [self.x; self.y];
        end
        
        function serialized = serialize(self)
        end
        
    end
    
end

