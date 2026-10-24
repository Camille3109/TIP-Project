close all

%% 1. Obtenir les prédictions sur le jeu de test
scores = minibatchpredict(net, audsTest);

%% 2. Récupérer les classes proprement depuis les labels d'entraînement
classNames = categories(imdsTrain.Labels);

%% 3. Trouver l'indice maximum pour chaque image et associer le nom du plat
[~, idxPred] = max(scores, [], 2);
labelsPred = classNames(idxPred);

%% 4. Génération directe du fichier JSON (contourne toutes les restrictions MATLAB)
filePaths = imdsTest.Files;
numImages = numel(filePaths);

fid = fopen('predictions.json', 'w');
fprintf(fid, '{\n');

for i = 1:numImages
    [~, imageName, ~] = fileparts(filePaths{i});
    imageNum = char(imageName);
    predLabel = char(labelsPred(i));
    
    % Écriture au format JSON : "numero": "prediction"
    if i < numImages
        fprintf(fid, '    "%s": "%s",\n', imageNum, predLabel);
    else
        fprintf(fid, '    "%s": "%s"\n', imageNum, predLabel);
    end
end

fprintf(fid, '}\n');
fclose(fid);

disp('Fichier predictions.json généré avec succès !');