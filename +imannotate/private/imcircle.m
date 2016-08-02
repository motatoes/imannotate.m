function [ h] = imcircle( varargin )
%IMCIRCLE Summary of this function goes here

    
    h = imellipse(varargin{:}, 'PositionConstraintFcn', @(pos) [pos(1) pos(2) max(pos(3:4)) max(pos(3:4))]);
end

