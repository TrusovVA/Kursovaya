function varargout = gui_kursovaya(varargin)
% GUI_KURSOVAYA MATLAB code for gui_kursovaya.fig
%      GUI_KURSOVAYA, by itself, creates a new GUI_KURSOVAYA or raises the existing
%      singleton*.
%
%      H = GUI_KURSOVAYA returns the handle to a new GUI_KURSOVAYA or the handle to
%      the existing singleton*.
%
%      GUI_KURSOVAYA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_KURSOVAYA.M with the given input arguments.
%
%      GUI_KURSOVAYA('Property','Value',...) creates a new GUI_KURSOVAYA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_kursovaya_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_kursovaya_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_kursovaya

% Last Modified by GUIDE v2.5 09-May-2015 17:00:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_kursovaya_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_kursovaya_OutputFcn, ...
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


% --- Executes just before gui_kursovaya is made visible.
function gui_kursovaya_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_kursovaya (see VARARGIN)

% Choose default command line output for gui_kursovaya
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_kursovaya wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_kursovaya_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal1
[openfile pathfile]=uigetfile('*.xlsx');
signal1=strcat(pathfile,openfile);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal2
[openfile pathfile]=uigetfile('*.xlsx');
signal2=strcat(pathfile,openfile);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal1
mod1=xlsread(signal1);
Fs=str2double(get(handles.edit2,'String'));
ls=length(mod1);
dF=Fs/ls;
f1=0:dF:Fs/2-1/ls;
f=0:dF:Fs-dF;
y1=fft(mod1);
N1=max(y1);
a1=abs(y1)/N1;
N3=length(mod1);
y3=abs(fft(mod1))/N3;
axes(handles.axes5); plot(f1,y3(1:length(f1))); grid; 
title('Спектр сигнала');
axes(handles.axes1); plot(f,a1); grid; xlim([0 50]);
title('Нормированный спектр сигнала');
xlabel('Частота дискретизации');
ylabel('Амплитуда');
a3=real(a1);
a4=a3(1:(N3/2));
[pks,locs]=findpeaks(a4);
locs2=locs*dF;
locs2=locs2';
pks=pks';
d=[locs2; pks];
rnames = {'X','Y'};
set(handles.uitable2,'data', d, 'RowName', rnames);
axes(handles.axes2); stem(locs2,pks); xlim([0 50]);
title('Резонансные частоты');
xlabel('Частота дискретизации');
ylabel('Амплитуда');

global signal2
mod2=xlsread(signal2);
y2=fft(mod2);
N2=max(y2);
a2=abs(y2)/N2;
a4=real(a2);
axes(handles.axes3); plot(f,a4); grid; xlim([0 50]);
title('Спектр сигнала испорченного белым шумом');
xlabel('Частота дискретизации');
ylabel('Амплитуда');
a22=smooth(f,a4,0.002);
axes(handles.axes4); plot(f,a22); grid; xlim([0 50]);
title('Сглаженный спектр зашумленного сигнала');
xlabel('Частота дискретизации');
ylabel('Амплитуда');
[pks1,locs1]=findpeaks(a22,'MinPeakHeight',0.15);
locs3=locs1*dF;




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
