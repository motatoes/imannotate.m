classdef LineAnnotationTest < matlab.unittest.TestCase
    %ELLIPSEANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
       % [x1, y1; x2, y2]
       positionCorrect = {[1, 2; 3, 4]};
       positionWrong = {[1, 2, 3; 4, 5, 6], ['a', 'b'; 'c', 'd']};
    end
    
    methods (Test)
                
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.LineAnnotation;            
            LA = LineAnnotation(positionCorrect);
            testCase.verifyEqual(LA.x1, positionCorrect(1,1));
            testCase.verifyEqual(LA.y1, positionCorrect(1,2));
            testCase.verifyEqual(LA.x2, positionCorrect(2,1));
            testCase.verifyEqual(LA.y2, positionCorrect(2,2));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.LineAnnotation;            

            LA = LineAnnotation();
            LA.setPosition(positionCorrect);
            testCase.verifyEqual(LA.x1, positionCorrect(1,1));
            testCase.verifyEqual(LA.y1, positionCorrect(1,2));
            testCase.verifyEqual(LA.x2, positionCorrect(2,1));
            testCase.verifyEqual(LA.y2, positionCorrect(2,2));
        end
        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.LineAnnotation;
            LA = LineAnnotation();
            testCase.verifyError(@() LA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end

        
    end
        
end

