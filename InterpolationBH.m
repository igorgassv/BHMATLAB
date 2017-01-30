%% BxH Interpolation (IP12R) %%
% GEDRE - Intelligence in Lighting
% Igor Vegner
% January 2017
%% RST %%
clear all
close all
clc

%% DATA %%
% Hpoints: magnetic field intensity
% Bpoints: magnetic flux density
Hpoints = [0   1    2    5    10   15 ]; 
Hpoints = Hpoints*79.5774715459424;       % Converts data to A/m

Bpoints = [0 3500  4300 4750 5000 5100]; 
Bpoints = Bpoints*1e-4;                   % Converts data to Tesla
%% COMPUTING & PLOT %%
% BxH
accuracy = 1e-2;                       
newH = 0:accuracy:Hpoints(end);           % linspace with the desired 
                                          % accuracy
newB = spline(Hpoints,Bpoints,newH);      % interpolation function

% Relative Permeability
miH = newH;
miIn = newB./newH;

% Differential Permeability
miHdiff = newH;
for i= 1:length(newH)-1
    midiff(i+1)=(newB(i+1) - newB(i))/(newH(i+1) - newH(i));
end;
midiff(1) = midiff(2);

% B x H Plot
figure(1);
plot(Hpoints,Bpoints,'*',newH,newB); 
grid on
title('B x H - IP12R (23 °C)');
xlabel('Magnetic Field Intensity H [A/m]');
ylabel('Magnetic Flux Density B [T]');

% Permeability Plot
figure(2);
plot(miH, miIn,miHdiff, midiff);
grid on
title('Permeability - IP12R (23 °C)');
xlabel('Magnetic Field Intensity H [A/m]');
ylabel('\mu [H/m]');
legend('\mu{r}','\mu{ds}');

% Zoom
figure(3);
plot(miH, miIn,miHdiff, midiff);
grid on
title('Permeability - IP12R (23 °C)');
xlabel('Magnetic Field Intensity H [A/m]');
ylabel('\mu [H/m]');
axis([400 max(newH) 0 0.0001])
legend('\mu{r}','\mu{ds}');