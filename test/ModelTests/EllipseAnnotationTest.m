classdef EllipseAnnotationTest < matlab.unittest.TestCase
    %ELLIPSEANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
       % [x, y, radius1, radius2]
       positionCorrect = {[1, 2, 3, 4]};
       positionWrong = {[1, 2, 3, 4, 5], ['a', 'b', 'c', 'd']};       
    end
    
    methods (Test)
                
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.EllipseAnnotation;            
            EA = EllipseAnnotation(positionCorrect);
            testCase.verifyEqual(EA.x, positionCorrect(1));
            testCase.verifyEqual(EA.y, positionCorrect(2));
            testCase.verifyEqual(EA.radius1, positionCorrect(3));
            testCase.verifyEqual(EA.radius2, positionCorrect(4));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.EllipseAnnotation;            

            EA = EllipseAnnotation();
            EA.setPosition(positionCorrect);
            testCase.verifyEqual(EA.x, positionCorrect(1));
            testCase.verifyEqual(EA.y, positionCorrect(2));
            testCase.verifyEqual(EA.radius1, positionCorrect(3));
            testCase.verifyEqual(EA.radius2, positionCorrect(4));
        end
        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.EllipseAnnotation;
            EA = EllipseAnnotation();
            testCase.verifyError(@() EA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end
        
    end
        
end

