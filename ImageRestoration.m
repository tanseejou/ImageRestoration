function varargout = ImageRestoration(varargin)
% IMAGERESTORATION MATLAB code for ImageRestoration.fig
%      IMAGERESTORATION, by itself, creates a new IMAGERESTORATION or raises the existing
%      singleton*.
%
%      H = IMAGERESTORATION returns the handle to a new IMAGERESTORATION or the handle to
%      the existing singleton*.
%
%      IMAGERESTORATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGERESTORATION.M with the given input arguments.
%
%      IMAGERESTORATION('Property','Value',...) creates a new IMAGERESTORATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageRestoration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageRestoration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageRestoration

% Last Modified by GUIDE v2.5 30-Nov-2019 17:15:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageRestoration_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageRestoration_OutputFcn, ...
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


% --- Executes just before ImageRestoration is made visible.
function ImageRestoration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageRestoration (see VARARGIN)

% Choose default command line output for ImageRestoration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageRestoration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageRestoration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in importImage.
function importImage_Callback(hObject, eventdata, handles)
% hObject    handle to importImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile({'*.png';'*.jpg';'*.bmp';'*.tif';'*.jpeg' });   
fullFile = fullfile(path, file);    % returns a character vector containing the full path to the file
I=imread(fullFile);
axes(handles.axes1);
imshow(I);
axes(handles.axes2);
imshow(I);
setappdata(handles.axes1, 'img', I);
setappdata(handles.axes2, 'img2', I);

% --- Executes on button press in medianFilter.
function medianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to medianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=getappdata(handles.axes2, 'img2');
J_median=medfilt2(J);
axes(handles.axes2);
imshow(J_median);
setappdata(handles.axes2, 'img2', J_median);


% --- Executes on button press in meanFilter.
function meanFilter_Callback(hObject, eventdata, handles)
% hObject    handle to meanFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=getappdata(handles.axes2, 'img2');
meanFilter=fspecial('average');
J_mean=imfilter(J,meanFilter);
axes(handles.axes2);
imshow(J_mean);
setappdata(handles.axes2, 'img2', J_mean);

% ----------SHARPENING IMAGE
% --- Executes on button press in sharpen.
function sharpen_Callback(hObject, eventdata, handles)
% hObject    handle to sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=getappdata(handles.axes2, 'img2');
J_sharp=imsharpen(J);
axes(handles.axes2);
imshow(J_sharp);
setappdata(handles.axes2, 'img2', J_sharp);
%***** another way of sharpen image ****
%Jd = im2double(J);
%laplacianFilter=fspecial('sharpen', 0);
%J_laplacian=imfilter(Jd, laplacianFilter);
%J_sharp=imsubtract(Jd, J_laplacian);
%axes(handles.axes2);
%imshow(J_sharp);



% --- Executes on button press in contrast.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=getappdata(handles.axes2, 'img2');
J_contrast=imadjust(J, stretchlim(J),[]);
axes(handles.axes2);
imshow(J_contrast);
setappdata(handles.axes2, 'img2', J_contrast);


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% cla reset;
arrayfun(@cla,findall(0,'type','axes')) % clear all the axe's element and axes


% --- Executes on button press in saveImage.
function saveImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imsave(handles.axes2);
