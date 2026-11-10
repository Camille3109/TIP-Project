close all

%% Lancement de l'application deepNetworkDesigner permettant de récupérer un pre-trained network
%%deepNetworkDesigner

%% Séparation de imdsTrain en Train (80%) et Validation (20%)
[imdsTrainSplit, imdsValSplit] = splitEachLabel(imdsTrain, 0.8, 'randomized');

%% Récupération de la taille d'entrée du réseau pré-entraîné
inputSize = network_ajoute.Layers(1).InputSize; 

%% Création des augmentedImageDatastore avec redimensionnement automatique
audsTrain = augmentedImageDatastore(inputSize(1:2), imdsTrainSplit);
audsVal   = augmentedImageDatastore(inputSize(1:2), imdsValSplit);
audsTest = augmentedImageDatastore(inputSize(1:2), imdsTest);

%% Configuration des options d'entraînement
miniBatchSize = 32;

options = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    "LearnRateSchedule", "piecewise", ...
    "LearnRateDropPeriod", 3, ...
    "LearnRateDropFactor", 0.1, ...
    'MaxEpochs', 4, ...
    'Shuffle', 'every-epoch', ...
    'MiniBatchSize', miniBatchSize, ...
    'ValidationData', audsVal, ... % <--- Utilisation du sous-ensemble de validation
    'ValidationFrequency', 100, ... % plus c'est important, moins l'entrainement est long
    'Verbose', false, ...
    'Plots', 'training-progress','Metrics','accuracy');

%% Lancement de l'entraînement
net = trainnet(audsTrain, network_ajoute, "crossentropy", options);