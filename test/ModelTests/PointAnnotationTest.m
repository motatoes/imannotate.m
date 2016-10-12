classdef PointAnnotationTest < matlab.unittest.TestCase
    %ELLIPSEANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
       % [x1, y1]
       positionCorrect = {[1, 2]};
       positionWrong = {[1, 2, 3], ['a', 'b']};
    end
    
    methods (Test)
        
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.PointAnnotation;            
            PA = PointAnnotation(positionCorrect);
            testCase.verifyEqual(PA.x, positionCorrect(1));
            testCase.verifyEqual(PA.y, positionCorrect(2));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.PointAnnotation;            

            PA = PointAnnotation();
            PA.setPosition(positionCorrect);
            testCase.verifyEqual(PA.x, positionCorrect(1));
            testCase.verifyEqual(PA.y, positionCorrect(2));
        end
        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.PointAnnotation;
            PA = PointAnnotation();
            testCase.verifyError(@() PA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end
        
    end
        
end

