close all

%% 2. Séparation de imdsTrain en Train (80%) et Validation (20%)
[imdsTrainSplit, imdsValSplit] = splitEachLabel(imdsTrain, 0.8, 'randomized');

%% 3. Récupération de la taille d'entrée du réseau pré-entraîné
inputSize = network_ajoute.Layers(1).InputSize; % Ex: [224 224 3]

%% 4. Création des datastores augmentés avec redimensionnement automatique
audsTrain = augmentedImageDatastore(inputSize(1:2), imdsTrainSplit);
audsVal   = augmentedImageDatastore(inputSize(1:2), imdsValSplit);

%% 5. Configuration des options d'entraînement
miniBatchSize = 32;

options = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    'MaxEpochs', 4, ...
    'Shuffle', 'every-epoch', ...
    'MiniBatchSize', miniBatchSize, ...
    'ValidationData', audsVal, ... % <--- Utilisation du sous-ensemble de validation ici !
    'ValidationFrequency', 40, ...
    'Verbose', false, ...
    'Plots', 'training-progress','Metrics','accuracy');

%% 6. Lancement de l'entraînement
net = trainnet(audsTrain, network_ajoute, "crossentropy", options);