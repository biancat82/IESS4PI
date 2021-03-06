%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/jacopobiancat/Documents/Scuola/2021-22/Astro_PI/MATLAB/IESS4PI/Data/data.csv
%
% Auto-generated by MATLAB on 30-May-2022 09:01:39

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 23);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Counter", "Datetime", "Latitude", "Longitude", "Elevation", "Sunlit", "CPUTemperature", "Temperature", "Humidity", "Pressure", "roll", "pitch", "yaw", "comp_x", "comp_y", "comp_z", "acc_x", "acc_y", "acc_z", "red", "green", "blue", "clear"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
data = readtable("/Users/jacopobiancat/Documents/Scuola/2021-22/Astro_PI/MATLAB/IESS4PI/Data/data.csv", opts);


%% Clear temporary variables
clear opts