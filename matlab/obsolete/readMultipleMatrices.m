%Reading multiple matrices
%clc,clear; cd '/Users/ema/Github/Data_aggregation/Matlab_files'; warning('off','all');
%folder = '/Users/ema/github/data_aggregation/data/ewe_networks';
%for k = 1 : length(theFiles)
%    file_pattern = fullfile(folder, '*matrix.txt');
%    theFiles = dir(file_pattern);
%    file_name = theFiles(k).name;
%    file = "/Users/ema/github/data_aggregation/data/ewe_networks/" + file_name;
%    A = readmatrix(file); n=length(A); network=digraph(A); network_U=graph(toundirected(A));
%    A_loopless = A;
%    %All the other code
%end