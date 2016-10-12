classdef AnnotationCollectionTest < matlab.unittest.TestCase
    %ANNOTATIONCOLLECTIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        annotation = {
            imannotate.models.PointAnnotation(), ...
            imannotate.models.LineAnnotation(), ...
            imannotate.models.CircleAnnotation(), ...
            imannotate.models.EllipseAnnotation(), ...
            imannotate.models.PointAnnotation(), ...
            imannotate.models.RectangleAnnotation(), ...
            imannotate.models.SquareAnnotation(), ...
        }
    end
    
    methods(Test)

        function testAddValidTagsFunction(testCase)
            AC = imannotate.models.AnnotationCollection();
            AC.addValidTag('mytag');
            % Adding it twice
            AC.addValidTag('mytag');  
            AC.addValidTag('mytag2');
            
            tags = AC.validTags;
            testCase.verifyEqual(sum(ismember(tags, 'mytag')), 1);
            testCase.verifyEqual(sum(ismember(tags, 'mytag2')), 1);
            testCase.verifyEqual(length(tags), 2);
        end

        function testAddInValidTagsFunction(testCase)
            AC = imannotate.models.AnnotationCollection();
            testCase.verifyError( @() AC.addValidTag(2), imannotate.exceptions.illegalArgumentException());
        end
        
        function testThatAValidAnnotationWorks(testCase, annotation)
            AC = imannotate.models.AnnotationCollection();
            AC.addValidTag('mytag');
            annotation.addTag('mytag');
            AC.addAnnotation(annotation);
            testCase.verifyEqual(annotation, AC.annotations{1});
        end        

        function testMultipleValidAnnotationsWork(testCase)
            AC = imannotate.models.AnnotationCollection();
            annotation1 = imannotate.models.CircleAnnotation();
            annotation2 = imannotate.models.EllipseAnnotation();
            AC.addAnnotation(annotation1);
            AC.addAnnotation(annotation2);
            testCase.verifyEqual(length(AC.annotations), 2);
        end
        
        function testThatAddingANonAnnotationThrowsError(testCase)
            AC = imannotate.models.AnnotationCollection();
            testCase.verifyError(@() AC.addValidTag(1), imannotate.exceptions.illegalArgumentException());            
        end
        

        function testAnAnnotationWithInvalidTagsThrowsError(testCase, annotation)
            AC = imannotate.models.AnnotationCollection();
            AC.addValidTag('mytag');
            annotation.removeTag('mytag');
            annotation.addTag('invalidtag');
            testCase.verifyError(@() AC.addAnnotation(annotation), imannotate.exceptions.illegalArgumentException() );
        end
        
    end
    
end

