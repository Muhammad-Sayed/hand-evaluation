function varargout = humanHandGUI(varargin)
% HUMANHANDGUI MATLAB code for humanHandGUI.fig
%      HUMANHANDGUI, by itself, creates a new HUMANHANDGUI or raises the existing
%      singleton*.
%
%      H = HUMANHANDGUI returns the handle to a new HUMANHANDGUI or the handle to
%      the existing singleton*.
%
%      HUMANHANDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUMANHANDGUI.M with the given input arguments.
%
%      HUMANHANDGUI('Property','Value',...) creates a new HUMANHANDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before humanHandGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to humanHandGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help humanHandGUI

% Last Modified by GUIDE v2.5 16-Dec-2015 17:06:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @humanHandGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @humanHandGUI_OutputFcn, ...
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


% --- Executes just before humanHandGUI is made visible.
function humanHandGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to humanHandGUI (see VARARGIN)

global hand;
global q;
%global skin;

hand = humanHand3();
q = hand.qHome;
%[skin.faces, skin.vertices, skin.normals] = stlread('\handModels\humanHand\hand.stl');
%skin.vertices = skin.vertices * (80/4000);
%skin.vertices = skin.vertices * (1/41.1); % mystrious scale problem
%plotHumanHand(hand, 0.5, 'r');
plotHandMesh6(hand, 0.1, 'r');
view(0, 0);
%plotMesh(skin, 0.3, 'b');
axis tight

% Choose default command line output for humanHandGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global az;
global al;
az = 0;
al = 0;

% UIWAIT makes humanHandGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = humanHandGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function IMC5_Callback(hObject, eventdata, handles)
% hObject    handle to IMC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{5}(1) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function IMC5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IMC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP5a_Callback(hObject, eventdata, handles)
% hObject    handle to MCP5a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{5}(2) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP5a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP5a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP5b_Callback(hObject, eventdata, handles)
% hObject    handle to MCP5b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{5}(3) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP5b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP5b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PIP5_Callback(hObject, eventdata, handles)
% hObject    handle to PIP5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{5}(4) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function PIP5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PIP5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DIP5_Callback(hObject, eventdata, handles)
% hObject    handle to DIP5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{5}(5) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function DIP5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DIP5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function IMC4_Callback(hObject, eventdata, handles)
% hObject    handle to IMC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{4}(1) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function IMC4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IMC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP4a_Callback(hObject, eventdata, handles)
% hObject    handle to MCP4a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{4}(2) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP4a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP4a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP4b_Callback(hObject, eventdata, handles)
% hObject    handle to MCP4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{4}(3) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PIP4_Callback(hObject, eventdata, handles)
% hObject    handle to PIP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{4}(4) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function PIP4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PIP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DIP4_Callback(hObject, eventdata, handles)
% hObject    handle to DIP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{4}(5) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function DIP4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DIP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function IMC3_Callback(hObject, eventdata, handles)
% hObject    handle to IMC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{3}(1) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function IMC3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IMC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP3a_Callback(hObject, eventdata, handles)
% hObject    handle to MCP3a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{3}(2) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP3a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP3a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP3b_Callback(hObject, eventdata, handles)
% hObject    handle to MCP3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{3}(3) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PIP3_Callback(hObject, eventdata, handles)
% hObject    handle to PIP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{3}(4) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function PIP3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PIP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DIP3_Callback(hObject, eventdata, handles)
% hObject    handle to DIP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{3}(5) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function DIP3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DIP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP2a_Callback(hObject, eventdata, handles)
% hObject    handle to MCP2a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{2}(1) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP2a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP2a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP2b_Callback(hObject, eventdata, handles)
% hObject    handle to MCP2b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{2}(2) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP2b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP2b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function PIP2_Callback(hObject, eventdata, handles)
% hObject    handle to PIP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{2}(3) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function PIP2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PIP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DIP2_Callback(hObject, eventdata, handles)
% hObject    handle to DIP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
global hand;

q{2}(4) = get(hObject,'Value');
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function DIP2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DIP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CMC1a_Callback(hObject, eventdata, handles)
% hObject    handle to CMC1a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
q{1}(1) = get(hObject,'Value');
global hand;
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function CMC1a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CMC1a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function CMC1b_Callback(hObject, eventdata, handles)
% hObject    handle to CMC1b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
q{1}(2) = get(hObject,'Value');
global hand;
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function CMC1b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CMC1b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP1a_Callback(hObject, eventdata, handles)
% hObject    handle to MCP1a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
q{1}(3) = get(hObject,'Value');
global hand;
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');

% --- Executes during object creation, after setting all properties.
function MCP1a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP1a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MCP1b_Callback(hObject, eventdata, handles)
% hObject    handle to MCP1b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
q{1}(4) = get(hObject,'Value');
global hand;
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function MCP1b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCP1b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function IP1_Callback(hObject, eventdata, handles)
% hObject    handle to IP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%global skin;
global q;
q{1}(5) = get(hObject,'Value');
global hand;
%handPose = humanHandPose( hand, q );
hand = handPosture2( hand, q );
cla;
%plotUpdateHumanHand( handPose, 0.5, 'r');
%plotMesh(skin, 0.3, 'b');
plotHandMesh6(hand, 0.1, 'r');


% --- Executes during object creation, after setting all properties.
function IP1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function az_Callback(hObject, eventdata, handles)
% hObject    handle to az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global az;
global el;
az = get(hObject,'Value');
view([az,el])


% --- Executes during object creation, after setting all properties.
function az_CreateFcn(hObject, eventdata, handles)
% hObject    handle to az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function al_Callback(hObject, eventdata, handles)
% hObject    handle to al (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global az;
global el;
el = get(hObject,'Value');
view([az,el])


% --- Executes during object creation, after setting all properties.
function al_CreateFcn(hObject, eventdata, handles)
% hObject    handle to al (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function TransX_Callback(hObject, eventdata, handles)
% hObject    handle to TransX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TransX as text
%        str2double(get(hObject,'String')) returns contents of TransX as a double


% --- Executes during object creation, after setting all properties.
function TransX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TransX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TransY_Callback(hObject, eventdata, handles)
% hObject    handle to TransY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TransY as text
%        str2double(get(hObject,'String')) returns contents of TransY as a double


% --- Executes during object creation, after setting all properties.
function TransY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TransY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TransZ_Callback(hObject, eventdata, handles)
% hObject    handle to TransZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TransZ as text
%        str2double(get(hObject,'String')) returns contents of TransZ as a double


% --- Executes during object creation, after setting all properties.
function TransZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TransZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RotX_Callback(hObject, eventdata, handles)
% hObject    handle to RotX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RotX as text
%        str2double(get(hObject,'String')) returns contents of RotX as a double


% --- Executes during object creation, after setting all properties.
function RotX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RotX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RotY_Callback(hObject, eventdata, handles)
% hObject    handle to RotY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RotY as text
%        str2double(get(hObject,'String')) returns contents of RotY as a double


% --- Executes during object creation, after setting all properties.
function RotY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RotY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RotZ_Callback(hObject, eventdata, handles)
% hObject    handle to RotZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RotZ as text
%        str2double(get(hObject,'String')) returns contents of RotZ as a double


% --- Executes during object creation, after setting all properties.
function RotZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RotZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in applyTransform.
function applyTransform_Callback(hObject, eventdata, handles)
% hObject    handle to applyTransform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in outputTransform.
function outputTransform_Callback(hObject, eventdata, handles)
% hObject    handle to outputTransform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in output_q.
function output_q_Callback(hObject, eventdata, handles)
% hObject    handle to output_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global q;
qThumb = q{1}
qIndex = q{2}
qMiddle = q{3}
qRing = q{4}
qSmall = q{5}
