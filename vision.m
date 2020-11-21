function varargout = vision(varargin)
% VISION MATLAB code for vision.fig
%      VISION, by itself, creates a new VISION or raises the existing
%      singleton*.
%
%      H = VISION returns the handle to a new VISION or the handle to
%      the existing singleton*.
%
%      VISION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISION.M with the given input arguments.
%
%      VISION('Property','Value',...) creates a new VISION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vision_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vision_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vision

% Last Modified by GUIDE v2.5 11-Dec-2015 02:54:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vision_OpeningFcn, ...
                   'gui_OutputFcn',  @vision_OutputFcn, ...
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


% --- Executes just before vision is made visible.
function vision_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vision (see VARARGIN)

% Choose default command line output for vision
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.axes1)
imshow('égale.tif')
global seuil
global X
[seuil,X]  = main()






% UIWAIT makes vision wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vision_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global pathname

[filename, pathname, filterindex] = uigetfile( ...
{  '*.tif','Tif-files (*.tif)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
if isequal(filename,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(pathname, filename)])
   set(handles.listbox1,'String', filename);
  % s = struct('name',{'image1.tif','image2.tif','image3.tif','image4.tif','image5.tif','image6.tif','image7.tif','image8.tif','image9.tif','image10.tif','image11.tif','image12.tif'});



end

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
global pathname
global seuil
global X
contents = cellstr(get(hObject,'String'))
%disp(contents)
axes(handles.axes4)
imshow( fullfile(pathname, contents{get(hObject,'Value')}))
resultat = fopen('Resultat.txt','w');
% on calcule les 4 matries de co-occurrence puis on calcule les 4
% paramètres " contrast correlation energy homogeneity " de chaque image     
x1 = CoOccurrence( fullfile(pathname, contents{get(hObject,'Value')}));

% on fait appel à la fonction trainTest qui a comme paramètre
% le tableau de moyennes des 4 paramètres de chaque image
% et le tableau de moyennes des 4 paramètres de la base de test 
val = trainTest(x1, X);
% on vérife si la valeur retournée ("la distance entre l'image et la base
% de test") est inférieure au seuil i.e c'est une image Egale
if val <= seuil
    res = 'Egale';
    set(handles.text6,'string',res, 'Foreground', [0 0 1]);
else % sinon c'est une image différente
    res = 'Différente';
    set(handles.text6,'string',res, 'Foreground', [1 0 0]);
end
disp(res)
%set(handles.text6,'string',res);
% on sauvegarde les résultats dans un fichier.
fprintf(resultat,'%s    %s      %f', contents{get(hObject,'Value')}, res, val);
fprintf(resultat,'\n');


fclose(resultat);


% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
