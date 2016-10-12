classdef (Abstract) Annotation < handle
    %ANNOTATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private);
        tags = {}; % A cell array of tags for each annotation
    end
    
    methods (Static)
        function validatePosition(position)
            if (~isnumeric(position))
                ME = MException(imannotate.exceptions.illegalArgumentException, 'Expected a numeric type but argument was not numeric.');
                throw(ME);
            end
        end
        
        function validateTag(tag)
            if (~ischar(tag))
                ME = MException(imannotate.exceptions.illegalArgumentException, 'Expected a Char type but argument was not Char.');
                throw(ME);                
            end
        end
    end
    
    methods

        function setPosition(self, position)            
            p = inputParser();
            addRequired(p, 'position', @(p) self.validatePosition(p));
            parse(p, position);            
        end
    
        function addTag(self, tag)
            self.validateTag(tag);
            self.tags = union(self.tags,tag);
        end
        
        function removeTag(self, tag)
            self.validateTag(tag);
            self.tags = setdiff(self.tags, tag);
        end
        
    end
    
    
    methods (Abstract)
        position = getPosition(self);
        
        serialized = serialize(self);
    end
        
end

