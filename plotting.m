function plotting(c,v,x1,y1,sample_size,ray_2,ray_3,n1,n2)

    % Definování vrcholů hranolu
    u1 = [0 c c/2];
    v1 = [0 0 v];
    w1 = [c,c/2,3*c/2,3*c/2];
    p1 = [0,v,3*c/2,0];
    hold on

    % vykreslení hranolu
    fill(u1, v1, 'w','FaceAlpha',0.5)

    % Pokud jsou indexy lomu venkovního prostředí a hranolu stejné,
    % projde dopadající paprsek nezlomen
    if n1 == n2

    % vykreslení nezlomeného dopadajícího paprsku
    plot(x1, y1,'w','LineWidth', 2);
    else

        % vykreslení dopadajícího paprsku
        plot(x1, y1,'w','LineWidth', 2);

        % vykreslení druhého paprsku
        colors = hsv(sample_size);
        for i = 1:sample_size
            plot(ray_2(:,1,i), ray_2(:,2,i), 'LineWidth', 1 ...
                , 'Color', colors(i,:));
        end
        fill(w1, p1, 'k')

        % vykreslení třetího paprsku
        for i = 1:sample_size
            plot(ray_3(:,1,i), ray_3(:,2,i), 'LineWidth', 1 ...
                , 'Color', colors(i,:));
        end
    end

    % Nastavení barvy pozadí figury na černou a nastavení hranic grafu
    set(gca,'Color','k','XColor', 'none','YColor','none','Color','k')
    axis equal;
    grid on;
    xlimit = [0,2*c];
    xlim(xlimit)
    ylim([0,v])
end