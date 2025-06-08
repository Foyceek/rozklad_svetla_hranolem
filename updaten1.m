function updaten1(~, ~)
% Fuknce, která aktualizuje graf po změně indexu lomu venkovního prostředí

    % Načtení uživatelských hodnot
    fig = gcf;
    data = guidata(fig);

    % Získání indexu lomu venkovního prostředí z editačního pole
    newn1 = str2double(data.n1Edit.String);

    % Získání nového indexu lomu hranolu z editačního pole
    newn2 = str2double(data.n2Edit.String);

    % Kontrola, zda je nová hodnota platná
    if isnan(newn1) || newn1 > 3 || newn1 < 1 || newn1 > newn2
        errordlg(['Invalid n1 value. n1 must be a number between' ...
            ' 1 and 3. n1 must be smaller than n2'], 'Error');
        set(data.n1Edit,'String','1')
    else
       
        % Aktualizace indexu lomu venkovního prostředí
        n1 = newn1;

        % Aktualizace indexu lomu pro každou vlnovou délku
        data.n = linspace(data.n2,data.n2+0.08*(abs(n1-data.n2)),data.sample_size);
        
        % Aktualizace parametrů hranolu
        [~,c,v,~,B,C,D,normalBC] = prism_parameters(data.omega);

        % Aktualizace parametrů prvního paprsku
        [x1,y1] = ray_1_parameters(data.alpha1,data.omega,c,D,n1,data.n2);
        
        % Aktualizace parametrů druhého paprsku
        [ray_2,beta1,betad,points] = ray_2_parameters(data.n,n1 ...
            ,data.alpha1,data.omega,data.sample_size,c,B,C,D);
        
        % Aktualizace parametrů tretího paprsku
        [ray_3] = ray_3_parameters(data.n,n1,data.omega,beta1,betad ...
            ,points,c,data.sample_size,normalBC);
        
        % Aktualizace grafu
        cla reset
        plotting(c,v,x1,y1,data.sample_size,ray_2,ray_3,n1,data.n2);

        % Uložení uživatelských hodnot
        data.n1 = n1;
        guidata(fig,data)
    end
end