function updateSample_size(~, ~)
% Fuknce, která aktualizuje graf po změně počtu promítnutých paprsků

    % Načtení uživatelských hodnot
    fig = gcf;
    data = guidata(fig);

    % Získání nového počtu promítnutých paprsků z editačního pole
    newSample_size = str2double(data.sample_sizeEdit.String);

    % Kontrola, zda je nová hodnota platná
    if isnan(newSample_size) || newSample_size < 1
        errordlg(['Invalid sample_size value. sample size must be' ...
            ' a number bigger than 1'], 'Error');
        set(data.sample_sizeEdit,'String','100')
    else

        % Aktualizace počtu promítnutých paprsků
        sample_size = newSample_size;

        % Aktualizace parametrů hranolu
        [~,c,v,~,B,C,D,normalBC] = prism_parameters(data.omega);
        n = linspace(data.n2,data.n2+0.08*(abs(data.n1-data.n2)) ...
            ,sample_size);

        % Aktualizace parametrů prvního paprsku
        [x1,y1] = ray_1_parameters(data.alpha1,data.omega,c,D ...
            ,data.n1,data.n2);
       
        % Aktualizace parametrů druhého paprsku
        [ray_2,beta1,betad,points] = ray_2_parameters(n,data.n1 ...
            ,data.alpha1,data.omega,sample_size,c,B,C,D);
       
        % Aktualizace parametrů tretího paprsku
        [ray_3] = ray_3_parameters(n,data.n1,data.omega,beta1,betad ...
            ,points,c,sample_size,normalBC);
       
        % Aktualizace grafu
        cla reset
        plotting(c,v,x1,y1,sample_size,ray_2,ray_3,data.n1,data.n2);

        % Uložení uživatelských hodnot
        data.n = n;
        data.sample_size = sample_size;
        guidata(fig,data)
    end
end