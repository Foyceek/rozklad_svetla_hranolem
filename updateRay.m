function updateRay(~, ~)
% Fuknce, která aktualizuje graf po změně úhlu dopadu

    % Načtení uživatelských hodnot
    fig = gcf;
    data = guidata(fig);

    % Získání nového úhlu dopadu z editačního pole
    newalpha1 = str2double(data.alpha1Edit.String);

    % Kontrola, zda je nová hodnota platná
    if isnan(newalpha1)|| newalpha1 > 90 || newalpha1 < 0
        errordlg(['Invalid alpha1 value. alpha1 must be' ...
            ' a number between 0 and 90'], 'Error');
        set(data.alpha1Edit,'String','60')
    else

        % Aktualizace úhlu dopadu
        alpha1 = newalpha1;

        % Aktualizace parametrů hranolu
        [~,c,v,~,B,C,D,normalBC] = prism_parameters(data.omega);

        % Aktualizace parametrů prvního paprsku
        [x1,y1] = ray_1_parameters(alpha1,data.omega,c,D,data.n1,data.n2);

        % Aktualizace parametrů druhého paprsku
        [ray_2,beta1,betad,points] = ray_2_parameters(data.n,data.n1 ...
            ,alpha1,data.omega,data.sample_size,c,B,C,D);

        % Aktualizace parametrů tretího paprsku
        [ray_3] = ray_3_parameters(data.n,data.n1,data.omega,beta1 ...
            ,betad,points,c,data.sample_size,normalBC);

        % Aktualizace grafu
        cla reset
        plotting(c,v,x1,y1,data.sample_size,ray_2,ray_3,data.n1,data.n2);

        % Uložení uživatelských hodnot
        data.alpha1 = alpha1;
        guidata(fig,data)
    end
end