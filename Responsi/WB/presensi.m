function varargout = presensi(varargin)
% PRESENSI MATLAB code for presensi.fig
%      PRESENSI, by itself, creates a new PRESENSI or raises the existing
%      singleton*.
%
%      H = PRESENSI returns the handle to a new PRESENSI or the handle to
%      the existing singleton*.
%
%      PRESENSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRESENSI.M with the given input arguments.
%
%      PRESENSI('Property','Value',...) creates a new PRESENSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before presensi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to presensi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help presensi

% Last Modified by GUIDE v2.5 25-Jun-2021 14:49:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @presensi_OpeningFcn, ...
                   'gui_OutputFcn',  @presensi_OutputFcn, ...
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


% --- Executes just before presensi is made visible.
function presensi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to presensi (see VARARGIN)

Maindata = xlsread('Real estate valuation data set.xlsx');%meinput data set
%memilih data yang akan ditampilkan dalam tabel
Maindata = [Maindata(:,3) Maindata(:,4) Maindata(:,5) Maindata(:,8)];
Maindata = Maindata(1:50,:);
set(handles.data,'Data',Maindata);%meinput data ke dalam tabel data


% Choose default command line output for presensi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes presensi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = presensi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data = xlsread('Real estate valuation data set.xlsx');
data = [data(:,3) data(:,4) data(:,5) data(:,8)];
data = data(1:50,:);
k = [0,0,0,1];%atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
w = [3,5,4,1];%Nilai bobot tiap kriteria
 
%tahapan pertama, perbaikan bobot
[m n] = size(data); %inisialisasi ukuran data
w  = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%normalisasi matrix 
S = zeros(m,1);%vektor s
V = zeros(m,1);%vektor v

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i,:)=prod(data(i,:).^w);
end;

%tahapan ketiga, perhitungan vektor (V)
for j=1:m,
    V(j,:) = S(j,:)/sum(sum(S));
end;

%proses memasukkan vektor s dan v ke dalam matriks
data = [data(:,1) data(:,2) data(:,3) data(:,4) S(:,1) V(:,1)];


%pengurutan hasil dari terbesar ke terkecil
data1= data;
for i=m:-1:1,
    for j=1:i-1,
       if data1(j,6)<data1(j+1,6),
           T = data1(j,:);
           data1(j,:) = data1(j+1,:);
           data1(j+1,:) = T; 
       end;
   end;
end;
set(handles.TabelV,'Data',data1); %menampilkan ke tabel hasil belum urut
% --- Executes when selected cell(s) is changed in uitable2.
function uitable2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
