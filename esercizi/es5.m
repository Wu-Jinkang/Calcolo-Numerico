addpath("functions");
format longEng
disp("Esercizio 5: ");

puntoInziale = pi/4;
[xfin, passi]= newton(puntoInziale, @sin, @cos);

fprintf('lo zero della funzione seno è nel %i tramite il metodo di Newton con %i passi, dato il punto di innesco %i.\n', xfin, passi, pi/2);

%La prima iterazione del metodo di Newton
puntoFinale = puntoInziale-sin(puntoInziale)/cos(puntoInziale);

[xfin, passi]= secanti(puntoInziale, puntoFinale, @sin);
fprintf('lo zero della funzione seno è nel %i tramite il metodo delle secanti con %i passi, dato il punto di innesco %i.\n', xfin, passi, pi/2);