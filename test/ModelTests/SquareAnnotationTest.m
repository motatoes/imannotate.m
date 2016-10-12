classdef SquareAnnotationTest < matlab.unittest.TestCase
    %SQUAREANNOTATIONTET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        positionCorrect = {[1, 2, 3]};
        positionWrong = {[1, 2, 3, 5], [1 2; 3 4], ['a', 'b', 'c']};
    end
    
    methods (Test)
                
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.SquareAnnotation;
            SA = SquareAnnotation(positionCorrect);
            testCase.verifyEqual(SA.x, positionCorrect(1));
            testCase.verifyEqual(SA.y, positionCorrect(2));
            testCase.verifyEqual(SA.side, positionCorrect(3) );
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.SquareAnnotation;
            SA = SquareAnnotation();
            SA.setPosition(positionCorrect);
            testCase.verifyEqual(SA.x, positionCorrect(1));
            testCase.verifyEqual(SA.y, positionCorrect(2));
            testCase.verifyEqual(SA.side, positionCorrect(3));
        end
        
        function testThatWrongArgumentThrowsillegalArgumentException(testCase, positionWrong)
            import imannotate.models.SquareAnnotation;
            SA = SquareAnnotation();
            testCase.verifyError(@() SA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end
        
    end
    
end

