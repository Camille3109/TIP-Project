function [imdsTrain, imdsTest] = prepare_data()

    %% Configuration des chemins d'accès
    rootDir = 'food-11';
    trainDir = fullfile(rootDir, 'train');
    testDir = fullfile(rootDir, 'test');
    
    %% 1. Préparation des données d'entraînement (Train)
    disp('Chargement des images d''entraînement...');
    
    % imageDatastore analyse automatiquement les sous-dossiers de 'train' 
    % (ex: bread, meat...) et les utilise comme catégories (labels).
    imdsTrain = imageDatastore(trainDir, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');
    
    %% 2. Préparation des données de test (Test)
    disp('Chargement des images de test...');
    
    % Puisqu'il n'y a pas de sous-dossiers dans 'test', on charge directement les images.
    imdsTest = imageDatastore(testDir);
    

    disp('Préparation de la base de données food-11 terminée.');
end