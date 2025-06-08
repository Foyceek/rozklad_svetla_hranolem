clear
close all
clc

n1 = 1;             % index lomu venkovního prostředí
n2 = 1.5;           % index lomu hranolu
omega = 60;         % lámavý úhel hranolu
alpha1 = 60;        % úhel dopadu
sample_size = 10;   % počet promítnutých paprsků

%% Zahájení datovou strukturu pro ukládání dat GUI
%počáteční hodnoty
data = struct();
data.n1 = n1;
data.n2 = n2;
data.omega = omega;
data.alpha1 = alpha1;
data.sample_size = sample_size;

%% parametry hranolu
[b,c,v,A,B,C,D,normalBC] = prism_parameters(omega);

%% parametry světla
% index lomu pro každou vlnovou délku
n = linspace(n2,n2+0.08*(abs(n1-n2)),sample_size);
data.n = n;

%% parametry prvního paprsku
[x1,y1] = ray_1_parameters(alpha1,omega,c,D,n1,n2);

%% parametry druhého paprsku
[ray_2,beta1,betad,points,direction] = ray_2_parameters(n,n1,alpha1 ...
    ,omega,sample_size,c,B,C,D);

%% parametry třetího paprsku
[ray_3] = ray_3_parameters(n,n1,omega,beta1,betad,points,c ...
    ,sample_size,normalBC);

%% Vytvoření nového okna
fig = figure('Name', 'Rozklad světla hranolem','units','normalized' ...
    ,'Position',[0.1,0.05,0.8,0.85],'tag', 'fig');
plotting(c,v,x1,y1,sample_size,ray_2,ray_3,n1,n2);
%% ovládání uživatelského prostředí
% left bottom width height
% Vytvoření editačního pole pro úpravu úhlu dopadu
alpha1Edit = uicontrol('Style', 'edit','units','normalized','Position', [0.1,0.05,0.03,0.03] ...
    , 'String', num2str(alpha1), 'Callback', @updateRay);

% Přidání onačení editačního pole
uicontrol('Style', 'text','units','normalized','Position', [0.05,0.04,0.04,0.05], 'String' ...
    , 'Úhel dopadu:');

% Vytvoření editačního pole pro úpravu lámavého úhlu
omegaEdit = uicontrol('Style', 'edit','units','normalized','Position', [0.25,0.05,0.03,0.03] ...
    , 'String', num2str(omega), 'Callback', @updatePrism);

% Přidání onačení editačního pole
uicontrol('Style', 'text','units','normalized','Position', [0.18,0.04,0.05,0.05], 'String' ...
    , 'Lámavý úhel hranolu:');

% Vytvoření editačního pole pro úpravu počtu promítnutých paprsků
sample_sizeEdit = uicontrol('Style', 'edit','units','normalized','Position', [0.4,0.05,0.03,0.03] ...
    , 'String', num2str(sample_size), 'Callback', @updateSample_size);

% Přidání onačení editačního pole
uicontrol('Style', 'text','units','normalized','Position', [0.33,0.04,0.05,0.06] ...
    , 'String', 'Počet promítnutých paprsků:');

% Vytvoření editačního pole pro úpravu indexu lomu venkovního prostředí
n1Edit = uicontrol('Style', 'edit','units','normalized','Position', [0.55,0.05,0.03,0.03] ...
    , 'String', num2str(n1), 'Callback', @updaten1);

% Přidání onačení editačního pole
uicontrol('Style', 'text','units','normalized','Position', [0.49,0.04,0.05,0.06], 'String' ...
    , 'Index lomu venkovního prostředí:');

% Vytvoření editačního pole pro úpravu indexu lomu hranolu
n2Edit = uicontrol('Style', 'edit','units','normalized','Position', [0.7,0.05,0.03,0.03] ...
    , 'String', num2str(n2), 'Callback', @updaten2);

% Přidání onačení editačního pole
uicontrol('Style', 'text','units','normalized','Position', [0.64,0.04,0.05,0.048], 'String' ...
    , 'Index lomu hranolu:');

% Vytvoření tlačítka pro resetování počátečních hodnot
uicontrol('Style', 'pushbutton','units','normalized','Position', [0.85,0.05,0.05,0.05] ...
    , 'String', 'Reset', 'Callback', @Reset);

% Vytvoření tlačítka pro zavření okna
uicontrol('Style', 'pushbutton','units','normalized','Position', [0.9,0.05,0.05,0.05] ...
    , 'String', 'Close', 'Callback', @Close);

msgbox(['Aplikace může ukazovat nepřesné výsledky v hraničních případech.' ...
    ' Například když paprsek vůbec nedorazí na druhou stranu hranolu' ...
    ' a místo toho dorazí na jeho dno. Zobrazení odraženého paprsku' ...
    ' při dosažení mezního úhlu je pouze symbolické'])
%% hodnoty zadané uživatelem
data.alpha1Edit = alpha1Edit;
data.omegaEdit = omegaEdit;
data.sample_sizeEdit = sample_sizeEdit;
data.n1Edit = n1Edit;
data.n2Edit = n2Edit;

% Uložení uživatelských hodnot do 'Uživatelských Hodnot' okna
guidata(fig, data);
