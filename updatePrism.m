function updatePrism(~, ~)
% Fuknce, která aktualizuje graf po změně lámavého úhlu

    % Načtení uživatelských hodnot
    fig = gcf;
    data = guidata(fig);

    % Získání nového lámavého úhlu z editačního pole
    newomega = str2double(data.omegaEdit.String);

    % Kontrola, zda je nová hodnota platná
    if isnan(newomega)|| newomega > 170 || newomega < 10
        errordlg(['Invalid omega value. omega must be' ...
            ' a number between 10 and 170'], 'Error');
        set(data.omegaEdit,'String','60')
    else

        % Aktualizace lámavého úhlu
        omega = newomega;
       
        % Aktualizace parametrů hranolu
        [~,c,v,~,B,C,D,normalBC] = prism_parameters(omega);
        
        % Aktualizace parametrů prvního paprsku
        [x1,y1] = ray_1_parameters(data.alpha1,omega,c,D,data.n1,data.n2);
        
        % Aktualizace parametrů druhého paprsku
        [ray_2,beta1,betad,points] = ray_2_parameters(data.n,data.n1 ...
            ,data.alpha1,omega,data.sample_size,c,B,C,D);
        
        % Aktualizace parametrů tretího paprsku
        [ray_3] = ray_3_parameters(data.n,data.n1,omega,beta1,betad ...
            ,points,c,data.sample_size,normalBC);
        
        % Aktualizace grafu
        cla reset
        plotting(c,v,x1,y1,data.sample_size,ray_2,ray_3,data.n1,data.n2);

        % Uložení uživatelských hodnot
        data.omega = newomega;
        guidata(fig,data)
    end
end