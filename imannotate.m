function varargout = imannotate(varargin)

import imannotate.*;
import imannotate.util.*;

% IMANNOTATE MATLAB code for imannotate.fig
%      IMANNOTATE, by itself, creates a new IMANNOTATE or raises the existing
%      singleton*.
%
%      H = IMANNOTATE returns the handle to a new IMANNOTATE or the handle to
%      the existing singleton*.
%
%      IMANNOTATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMANNOTATE.M with the given input arguments.
%
%      IMANNOTATE('Property','Value',...) creates a new IMANNOTATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imannotate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imannotate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imannotate

% Last Modified by GUIDE v2.5 28-Feb-2016 03:41:42
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imannotate_OpeningFcn, ...
                   'gui_OutputFcn',  @imannotate_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imannotate is made visible.
function imannotate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imannotate (see VARARGIN)
    

% Choose default command line output for imannotate
handles.output = hObject;
if (nargin == 3)
    [fname fpath] = uigetfile('*.m','Pick settings file');
    if (fpath == 0)
        error('You must specify a settings file .. exiting');
    end
    % Extracting only the path and the filename without extension
    [fpath fnamenoext fext] = fileparts([fpath fname]);
    addpath(fpath);
    settings_file = [fnamenoext];
    
elseif (nargin == 4)
    [fpath fnamenoext fext] = fileparts(varargin{1});
    addpath(fpath);
    settings_file = [fnamenoext];
    % Loading some variables from the settings file (SETTINGS class)
else
    error('%s\n%s\%s', 'Usage: imannotate', ...
                       '       imannotate <settings_file_name>', ...
           'to see example settings files type edit imannotate.settings.SquaresExample');
end

SETTINGS = eval(settings_file);
    
%===========================

handles.SETTINGS = SETTINGS;
handles.currentPath = handles.SETTINGS.START_PATH;


handles.imageViewer = figure();




% UIWAIT makes imannotate wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.markers = imannotate.MarkerCollection(handles.SETTINGS.CATEGORIES, handles.imageViewer);

for i=1:length(SETTINGS.CATEGORIES)
    category = SETTINGS.CATEGORIES(i).label;
    btnStr = strcat('Add', ' ', category);
    uicontrol(handles.markerLabelsBtnGrp, 'Style', 'pushbutton', ...
                                          'String', btnStr, ...
                                          'Position', [10 20*i 150 20], ...
                                          'Callback', ...
                                          @(~,~) addMarker(hObject, eventdata, handles, category) );
end

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = imannotate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ImagesListBox.
function ImagesListBox_Callback(hObject, eventdata, handles)
% hObject    handle to ImagesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% This resets the axis range to avoid zoomed in images
cla reset

% Hints: contents = cellstr(get(hObject,'String')) returns ImagesListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImagesListBox
items = get(handles.ImagesListBox, 'string');
index_selected = get(handles.ImagesListBox,'Value');

img = imread( strcat(handles.currentPath, '\', items{index_selected}) );
% handles.ImagesListBox
figure(handles.imageViewer);
imshow( img );

% load all the marker variables (exudates, microaneurysms, haemorhages) [if
% exists]
markers_prefix = handles.SETTINGS.MARKERS_FILE_SUFFIX;
filename = strcat(handles.SETTINGS.MARKERS_PATH, '\', items{index_selected}, markers_prefix);

handles.markers.reset();

if exist(filename, 'file')
    markerPositions = imannotate.util.getSerializedObject( filename  );
%     load(filename);
    
    handles.markers.loadMarkers(markerPositions);
%     [handles.exudates, handles.haemorhages, handles.microaneurysms ] = show_markers(exudate_positions, haemorhage_positions, microaneurysm_positions, gca);
else
    % Reset all the exudate values
%     handles.markers = {};
end

handles.currentImage = img;
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ImagesListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on key press with focus on selectDirButton and none of its controls.
function selectDirButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectDirButton (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was presse5d, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% [fileNames, pathName, filterIndex] = uigetfile({'*.*';'*.jpg';'*.tif';'*.png'}, 'Select file(s)', 'MultiSelect', 'on');
% if iscell(fileNames)
%     nbfiles = length(fileNames);
% elseif fileNames ~= 0
%     nbfiles = 1;
% else
%     nbfiles = 0;
% end
[pathname] = uigetdir(handles.currentPath);
% If the user cancels
if (pathname == 0)
    return;
end

jpg =  strcat(pathname, '\*.jpg');
jpeg = strcat(pathname, '\*.jpeg');
tif =  strcat(pathname, '\*.tif');
tiff = strcat(pathname, '\*.tiff');
png =  strcat(pathname, '\*.png');
bmp =  strcat(pathname, '\*.bmp');

% Just counting the number of files returned
imagesData = [dir(jpg); dir(jpeg); dir(tif); dir(tiff); dir(png); dir(bmp)];
% dirIndex = imagesData.isdir;
% imageList = imageData.name(~isDir);

lst = {};
cnt=1;
for i=1:length(imagesData)
    if (~imagesData(i).isdir)
        lst{cnt} = imagesData(i).name;
        cnt = cnt+1;
    end
end

set(handles.ImagesListBox, 'string', lst);
% We will need the current path for later
handles.currentPath = pathname;
guidata(hObject,handles);

% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ImagesListBox, 'string', {});



% --- Executes on button press in saveMarkersButton.
function saveToolbarMenu_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to saveMarkersButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
items = get(handles.ImagesListBox, 'string');
index_selected = get(handles.ImagesListBox,'Value');

markers_path = handles.SETTINGS.MARKERS_PATH;
markers_prefix = handles.SETTINGS.MARKERS_FILE_SUFFIX;
filename = strcat(markers_path, '\', items{index_selected}, markers_prefix);
% save(filename, 'exudate_positions', 'microaneurysm_positions', 'haemorhage_positions');
markerPositions = handles.markers.serialize();
save(filename, 'markerPositions');



% --- Executes on button press in visualizeBtn.
function visualizeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to visualizeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img = handles.currentImage;
res = img;
markerPositions = handles.markers.serialize();
mask = serializedObj2binaryMask(markerPositions);

outline = bwperim(mask);
res(outline) = 1;

figure; imshow(res);


%===================Dynamic callbacks ==============================%
function addMarker(hObject, eventdata, handles, category)
    handles.markers.addMarker(category);
%=================== User Funcations ==============================%


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
