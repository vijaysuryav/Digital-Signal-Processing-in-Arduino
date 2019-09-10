function varargout = Windows_GUI(varargin)
% WINDOWS_GUI MATLAB code for Windows_GUI.fig
%      WINDOWS_GUI, by itself, creates a new WINDOWS_GUI or raises the existing
%      singleton*.
%
%      H = WINDOWS_GUI returns the handle to a new WINDOWS_GUI or the handle to
%      the existing singleton*.
%
%      WINDOWS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOWS_GUI.M with the given input arguments.
%
%      WINDOWS_GUI('Property','Value',...) creates a new WINDOWS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Windows_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Windows_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Windows_GUI

% Last Modified by GUIDE v2.5 23-Mar-2019 17:05:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Windows_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Windows_GUI_OutputFcn, ...
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


% --- Executes just before Windows_GUI is made visible.
function Windows_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Windows_GUI (see VARARGIN)

% Choose default command line output for Windows_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Windows_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Windows_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double
input = str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
 set(hObject,'String','0')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in compute.
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice =  str2num(get(handles.n,'String'));
N = str2num(get(handles.M,'String'));
M=(N-1)/2;
% x=zeros(2*M+1);
% X=zeros(2*M+1);

switch choice
    case 1 %triangular
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=1-abs(n(k))/M;
        end
    case 2 %hanning
        for k=1:2*M+1
            n(k)=k-M-1;
            x(k)=0.5+0.5*cos(n(k)*pi/M);
        end
    case 3 %hamming
        for k=1:2*M+1
            n(k)=k-M-1;
            x(k)=0.54+0.56*cos(n(k)*pi/M);
        end
    case 4 %blackmann
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=0.42+0.5*cos(n(k)*pi/M)+0.08*cos(2*n(k)*pi/M);
        end
    case 5 %rectangular
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=1;
        end
    case 6 %Gaussian
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=exp(-0.5*(((n(k))/(N/4))^2));
        end
    case 7 %sine
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=sin(n(k)*pi/N);
        end
    case 8 %sine-squared
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=(sin(n(k)*pi/N))^2;
        end
    case 9 %Poisson
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=exp(-abs(n(k)*0.04));
        end
     case 10 %welch
        for k=1:2*M+1
            n(k)=k-M;
            x(k)=1-(n(k)/(N/2))^2;
        end 
    otherwise
        disp('Invalid Option');
        return;
end
w = 0:0.01:pi;
X = zeros(1, length(w));
a=0:N-1;
for p=1:length(w)
    X(p)=exp(-1j*a*w(p))*(x');
end
mag=20*log10(abs(X));

axes(handles.dts)
stem(n,x);
xlabel('n');
ylabel('Window function');

axes(handles.mag_spectrum);
plot(w,mag);
xlabel('Angular Frequency (rad/sec)');
ylabel('Magnitude Spectrum (dB)');
[pks,locs] = findpeaks(mag);

main_lobe=num2str(mag(1));
side_lobe=num2str(pks(1));

for k=1:length(mag)
    if(mag(k)<mag(k+1))
        firstnull=w(k);
        break;
    end
end

for k=1:length(mag)
    if(mag(k)<3)
        three_db_point=w(k);
        break;
    end
end

mainlobe_width=num2str((2*firstnull)/(2*pi));
transition_width=num2str((firstnull-three_db_point)/(2*pi));

set(handles.mainlobe,'String',main_lobe);
set(handles.sidelobe,'String',side_lobe);
set(handles.mainlobewidth,'String',mainlobe_width);
set(handles.transitionwidth,'String',transition_width);

guidata(hObject, handles); %updates the handles



function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double
input = str2num(get(hObject,'String'));
%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
 set(hObject,'String','0')
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
