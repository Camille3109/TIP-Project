clear all
close all

% Préparation de la base d'apprentissage, de la base de test, des labels apprentissage et des labels tests

% Chargement de la base de données food-11
% On utilise imageDatastore de Matlab. 

[imdsTrain, imdsTest] = prepare_data;
