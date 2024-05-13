[filename, pathname] = uigetfile('.', 'Select Test image');
filewithpath=strcat(pathname, filename);
img = imread(filewithpath);
[bbox, score, label] = detect(rcnn, img, 'MiniBatchSize', 32);
nobox=size(score, 1);
scorebox=[score, bbox];
scorebox = sortrows(scorebox, 'descend');
%img = insertObjectAnnotation(img, 'rectangle', scorebox(1,2:end), strcat('Stop Sign: Conf, Score: ', num2str(scorebox(1, 1))));
% Aggiunge annotazioni visive per tutti gli oggetti rilevati
for i = 1:nobox
    if score(i) >=0.95
        img = insertObjectAnnotation(img, 'rectangle', bbox(i,:), ...
            strcat('Stop Sign: Conf. Score: ', num2str(score(i))));
    end
end

% Visualizza l'immagine con le annotazioni
figure
imshow(img)