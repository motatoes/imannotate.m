classdef PropertiesTest < matlab.unittest.TestCase
    %ANNOTATIONCOLLECTIONTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (TestParameter)
        validShapeName = {'circle', 'square', 'rectangle', 'ellipse', 'point', 'line', 'polygon'};
        invalidShapeName = {'asfd', 3, [], {}};
        validShapeClass = imannotate.settings.Properties.validShapeClasses;
        invalidShapeClass = {'asdas', 3, {}, {} };
    end
    
    methods(Test)
        function testThatValidShapeNameReturnsAValidClass(testCase, validShapeName)
            import imannotate.settings.Properties;
            shapeClass = Properties.validShapeClass(validShapeName);
            testCase.verifyEqual(class(shapeClass), 'char');
        end
        
        function testThatInvalidShapeNameRaisesError(testCase, invalidShapeName)
            import imannotate.settings.Properties;
            testCase.verifyError(@() Properties.validShapeClass(invalidShapeName), imannotate.exceptions.illegalArgumentException() );
        end
        
        function testThatValidShapeClassReturnAValidShapeName(testCase, validShapeClass)
            
        end
        
        function testThatInvalidShapeClassRaisesError(testCase, invalidShapeClass)
            testCase.verifyError(@() Properties.validShapeName(invalidShapeClass), imannotate.exceptions.illegalArgumentException() );
            import imannotate.settings.Properties;
            
        end
    end
end