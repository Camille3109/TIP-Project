# TIP-Project

1) Executer start_database.m à chaque ouverture de Matlab.  
2) Executer network_training.m.
      Deep Network Designer s'ouvre. 
      Ouvrir SqueezeNet.  
      Dans le bloc conv10 :
      Activer Unlock Layer et modifier :  
        NumFilters = 11  
        WeightLearnRateFactor = 10  
        BiasLearnRateFactor = 10  
      Exporter sous le nom "network_ajoute". 
3) Une fois l'exécution de network_training.m terminée, exécuter prediction_test.m. 
   Un fichier json nommé prediction.json est créé. Il contient les prédictions du modèle sur les images test. 
