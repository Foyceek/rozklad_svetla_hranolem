function Reset(~, ~)

% Resetování všech hodnot do původního stavu
fig = gcf;
data = guidata(fig);
data.n1Edit.String = '1';
data.n2Edit.String = '1.5';
data.alpha1Edit.String = '60';
data.omegaEdit.String = '60';
data.sample_sizeEdit.String = '10';

updateSample_size;

updateRay;

updatePrism;

updaten1;

updaten2;
end