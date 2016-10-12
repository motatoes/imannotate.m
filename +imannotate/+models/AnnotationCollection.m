classdef AnnotationCollection < handle
   
    properties(SetAccess=private, GetAccess=public)
        annotations = {};
        % What category does this collection belong to?
        category;

        validTags = {};
    end
    
    methods
        function validateAnnotation(self, annotation)
            if (~isa(annotation, 'imannotate.models.Annotation'))
                ME = MException(imannotate.exceptions.illegalArgumentException, 'The argument passed was of the wrong type.');
                throw(ME);
            end
            % Ensure that the annotation's tags are valid
            tags = annotation.tags;
            tagsNotEmpty = ~isempty(tags) && ~isempty(self.validTags);
            if (tagsNotEmpty)
                tagmembercount = sum( ismember( tags, self.validTags) );
                if ( tagmembercount == 0 )
                    ME = MException(imannotate.exceptions.illegalArgumentException, 'The annotation does not contain a valid tag member.');
                    throw(ME);
                end
            end
        end
        
    end
    
    methods
        function obj = AnnotationCollection(varargin)
            p = inputParser();
            addOptional(p, 'category', 'uncategorised');
            parse(p, varargin{:});
            obj.setCategory(p.Results.category);
        end
        
        function addAnnotation(self, annotation)
            p = inputParser();
            addRequired(p, 'annotation', @(x) self.validateAnnotation(x));
            parse(p, annotation);
            % appending the annotation
            self.annotations = [self.annotations, {annotation}];
        end
        
        function setCategory(self, category)
            p = inputParser();
            addRequired(p, 'category', @(x) validateattributes(x, {'char'}, {}));
            
            parse(p, category);
            self.category = p.Results.category;
        end
        
        function resetTags(self)
            % Need to  check whether this will conflict with  the tags a
            % already in the annotations array
            self.validTags = {}; 
        end
        
        function addValidTag(self, tag)
            % ensure that the tag is valid
            imannotate.models.Annotation.validateTag(tag);
            self.validTags = union(self.validTags, tag);
        end
        
        function deleteValidTag(self, tag)
            % ensure that the tag is valid
            imannotate.models.Annotation.validateTag(tag);
            self.validTags = setdiff(self.validTags, tag);
        end
        
        % Verify whether an update in the tag structure will 
        function isValid = verifyValidTagsUpdate(self, newTagList)
            % to implement
        end
        
    end
    
end
