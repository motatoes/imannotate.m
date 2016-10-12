classdef PolygonAnnotationTest < matlab.unittest.TestCase
    %POLYGONANNOTATIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        % [x1, x2, x3 ... xn; y1, y2, y3, .. yn]
        positionCorrect = {[1 2 3; 4 5 6]};
        positionWrong = {[], zeros(2,0), ['a', 'b'; 'c', 'd']};
    end
    
    methods(Test)
        function testThatPositionIsBeingSetCorrectlyInConstructor(testCase, positionCorrect)
            import imannotate.models.PolygonAnnotation;            
            PA = PolygonAnnotation(positionCorrect);
            testCase.verifyEqual(PA.x, positionCorrect(1, :));
            testCase.verifyEqual(PA.y, positionCorrect(2, :));
        end
        
        function testThatPositionIsBeingSetCorrectlyInSetter(testCase, positionCorrect)
            import imannotate.models.PolygonAnnotation;            

            PA = PolygonAnnotation();
            PA.setPosition(positionCorrect);
            testCase.verifyEqual(PA.x, positionCorrect(1, :));
            testCase.verifyEqual(PA.y, positionCorrect(2, :));
        end
        
        function testThatWrongArgumentThrowillegalArgumentException(testCase, positionWrong)
            import imannotate.models.PolygonAnnotation;
            PA = PolygonAnnotation();
            testCase.verifyError(@() PA.setPosition(positionWrong), imannotate.exceptions.illegalArgumentException()); 
        end
        
    end
    
end

