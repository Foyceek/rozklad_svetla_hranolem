function Close(~, ~)

% Nalezení správné figury a její zavření
fig = findobj('type', 'figure', 'tag', 'fig');
close(fig);
end