function varargout = SAW(varargin)
% SAW MATLAB code for SAW.fig
%      SAW, by itself, creates a new SAW or raises the existing
%      singleton*.
%
%      H = SAW returns the handle to a new SAW or the handle to
%      the existing singleton*.
%
%      SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW.M with the given input arguments.
%
%      SAW('Property','Value',...) creates a new SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 10:00:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_OutputFcn, ...
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


% --- Executes just before SAW is made visible.
function SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW (see VARARGIN)

Maindata = xlsread('Data Rumah.xlsx');
Maindata = [Maindata(:,1) Maindata(:,3) Maindata(:,4) Maindata(:,5) Maindata(:,6) Maindata(:,7) Maindata(:,8)];

set(handles.base,'Data',Maindata);

% Choose default command line output for SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Maindata = xlsread('Data Rumah.xlsx');
data = [Maindata(:,3) Maindata(:,4) Maindata(:,5) Maindata(:,6) Maindata(:,7) Maindata(:,8)];


k = [0 1 1 1 1 1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w = [0.3, 0.2, 0.23, 0.1, 0.07, 0.1];% bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m n] = size(data);%matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,1); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=data(:,j)./max(data(:,j));
 else
  R(:,j)=min(data(:,j))./data(:,j);
 end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
 V(i,:)= sum(w.*R(i,:));
end;


%membuat matriks dataHasil untuk menyimpan data no dan V
dataHasil = [Maindata(:,1) V];

%pengurutan perankingan dari nilai V terbesar ke terkecil

for i=m:-1:1,
    for j=1:i-1,
       if dataHasil(j,2)<dataHasil(j+1,2),
           x = dataHasil(j,:);
           dataHasil(j,:) = dataHasil(j+1,:);
           dataHasil(j+1,:) = x; 
       end;
   end;
end;
set(handles.hasil,'Data',dataHasil);%menampilkan isi dataHasil ke tabel hasil



% --- Executes during object deletion, before destroying properties.
function base_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
