function [ serializedObj ] = getSerializedObject( matfilepath )
%GETSERIALIZEDOBJECT Loads the serialized and returns it
%   matfilepath is a path to the .mat file saved by the GUI interface

    if  (exist(matfilepath, 'file'))
        load(matfilepath);
        serializedObj = markerPositions;
    else
        error('The path to the following matfile is non-existant: %s', matfilepath);
    end
end

