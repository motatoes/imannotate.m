classdef EllipseAnnotation < imannotate.models.Annotation
    %ELLIPSEANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private)
        x;
        y;
        radius1;
        radius2
    end
    
    methods (Static)
        function validatePosition(position)
            % Call parent constructor
            validatePosition@imannotate.models.Annotation(position);
            
            % Validate the size of the passed position parameter            
            if ( size(position,1) ~= 1 || size(position,2) ~= 4  )
                ME = MException(imannotate.exceptions.illegalArgumentException(), 'The variable passed was of the wrong size');
                throw(ME);
            end
        end
    end
    
    methods
        
        function obj = EllipseAnnotation(varargin)
            if (nargin == 1)
                obj.setPosition(varargin{1});
            end
        end
        
        function setPosition(self, position)            
            setPosition@imannotate.models.Annotation(self, position);
            
            self.x = position(1);
            self.y = position(2);
            self.radius1 = position(3);
            self.radius2 = position(4);
        end
        
        function position = getPosition(self)
            position = [self.x, self.y, self.radius1, self.radius2];
        end
        
        function serialized = serialize(self)
        end
        
    end
    
end

