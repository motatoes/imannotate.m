classdef RectangleAnnotationTest < matlab.unittest.TestCase
    %RECTANGLEANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        positionCorrect = {[1 2 3 4]};
        positionWrong = {[1 2 3 4 5], [1, 2; 3 4], ['a' 'b' 'c' 'd']};
    end
    
    methods(Test)
        
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.RectangleAnnotation;            
            RA = RectangleAnnotation(positionCorrect);
            testCase.verifyEqual(RA.x, positionCorrect(1));
            testCase.verifyEqual(RA.y, positionCorrect(2));
            testCase.verifyEqual(RA.width, positionCorrect(3));
            testCase.verifyEqual(RA.height, positionCorrect(4));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.RectangleAnnotation;            

            RA = RectangleAnnotation();
            RA.setPosition(positionCorrect);
            testCase.verifyEqual(RA.x, positionCorrect(1));
            testCase.verifyEqual(RA.y, positionCorrect(2));
            testCase.verifyEqual(RA.width, positionCorrect(3));
            testCase.verifyEqual(RA.height, positionCorrect(4));
        end

        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.RectangleAnnotation;
            RA = RectangleAnnotation();
            testCase.verifyError(@() RA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end
        
    end
    
end

