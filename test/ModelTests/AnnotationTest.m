classdef AnnotationTest < matlab.unittest.TestCase
    
    properties (TestParameter)
       wrongTag = {[1]}; 
    end
    methods (Test)
        function testThatWeCanAddATag(testCase)
            PA = imannotate.models.PointAnnotation();
            
            PA.addTag('mytag');
            tags = PA.tags;
            testCase.verifyEqual(ismember(tags, 'mytag'), true);
            
        end
        
        function testThatDuplicatesDontGetAdded(testCase)
            PA = imannotate.models.PointAnnotation();
            
            PA.addTag('mytag');
            PA.addTag('mytag');
            tags = PA.tags;
            testCase.verifyEqual(length(tags), 1);
        
        end
        
        
        function testThatWeCanRemoveATag(testCase)
            PA = imannotate.models.PointAnnotation();
            
            PA.addTag('mytag');
            PA.addTag('mytag2');
            PA.addTag('mytag3');
            PA.removeTag('mytag');
            tags = PA.tags;
            testCase.verifyEqual(length(tags), 2);
            
        end
        
        function testRemovingAtagThatDoesNotExist(testCase)
            PA = imannotate.models.PointAnnotation();
            
            PA.addTag('mytag');
            PA.removeTag('mytag2');
            tags = PA.tags;
            testCase.verifyEqual(length(tags), 1);
          
        end
        
        function testAddingAnInvalidTag(testCase, wrongTag)
            PA = imannotate.models.PointAnnotation();
            testCase.verifyError( @()PA.addTag(wrongTag), imannotate.exceptions.illegalArgumentException() );
        end
        
    end
    
end