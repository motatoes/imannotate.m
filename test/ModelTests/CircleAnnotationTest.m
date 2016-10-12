classdef CircleAnnotationTest < matlab.unittest.TestCase
    %CIRCLEANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(TestParameter)
        % [x, y, radius]
        positionCorrect = {[1, 2, 3]};
        positionWrong = {[1, 2, 3, 4], ['a', 'b', 'c']};
    end
    
    
    methods (Test)
                
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.CircleAnnotation;
            
            CA = CircleAnnotation(positionCorrect);
            testCase.verifyEqual(CA.x, positionCorrect(1));
            testCase.verifyEqual(CA.y, positionCorrect(2));
            testCase.verifyEqual(CA.radius, positionCorrect(3));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.CircleAnnotation;

            CA = CircleAnnotation();
            CA.setPosition(positionCorrect);
            testCase.verifyEqual(CA.x, positionCorrect(1));
            testCase.verifyEqual(CA.y, positionCorrect(2));
            testCase.verifyEqual(CA.radius, positionCorrect(3));
        end
        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.CircleAnnotation;
            CA = CircleAnnotation();
            testCase.verifyError(@() CA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException());
        end
        
    end
    
end

