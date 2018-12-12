% FOLDERS/FILES WITH '.' AT THE START OF THEIR NAME WILL BE IGNORED WHEN
% USING 'all'
addpath(genpath('E:\GitHub\htlab-ephys-pipeline\MATLAB-Analysis\spikeSorting'))
%% Converting Open-Ephs Data (organised in folders) to Binary Files needed for Spike Sorting

% Folder separator: Windows = '\' Linux = '/'
    pathToDataFolder    = 'K:\Ephys\181207\1';   % If script already can reach dataFolder, set to ''
    dataFolderNames     = 'all';% String array (DOUBLE QUOTES) such as ["181108",...] OR 'all' 
    opt.overwriteFiles      = 0;    % 1 = overwrite, 0 = do not overwrite
    
% Data Channel(s) - 100_CH<>.continuous files
    dataCh              = 17;  % Array
% PhotoDiode Channel - 100_ADC<>.continuous files
    adcCh               = 1;    % Array
    
% Output parameters
    nChDesired          = 4;    % Number of signal channels needed
                                % Must be larger or equal to number of channels in dataChan
                                % If larger, dummy channels are padded with 1s
    opt.interlaceCh         = 0;    % 1 = interlace, 0 = do not interlace
                                % by default the length(dataChan) is divided by 2 and
                                % the second half interlaces into the first
                                % change order of interlacing by changing order of
                                % elements in dataChan array
    opt.invertCh            = 0;    % 1 = invert, 0 = do not invert
    opt.mergeCh             = 1;    % 1 = merge data, 0 = do not merge data
    opt.subtract50          = 30000;    % subtract lowpass of 100Hz cutoff (put in single channel sampling rate here!)

OEtoBin(pathToDataFolder,dataFolderNames,dataCh,adcCh,nChDesired,opt)

%% Converting .bin files (organised in a single folder) to Binary Files needed for Spike Sorting

% Folder separator: Windows = '\' Linux = '/'
    pathToDataFolder    = 'E:\Box Sync\DragonVision_DanielKo\Data\Ephys\testEnv';   % If script already can reach dataFolder, set to ''
    dataNames     = 'all';% String array (DOUBLE QUOTES) such as ["181108",...] OR 'all' 
    opt.overwriteFiles      = 1;    % 1 = overwrite, 0 = do not overwrite
    
% Data Channel(s) - 100_CH<>.continuous files
    dataCh              = 4;  % Number of channels in input .bin
    
% Output parameters
    nChDesired          = 4;    % Number of signal channels needed
                                % Must be larger or equal to number of channels in dataChan
                                % If larger, dummy channels are padded with 1s
    opt.interlaceCh         = 0;    % 1 = interlace, 0 = do not interlace
                                % by default the length(dataChan) is divided by 2 and
                                % the second half interlaces into the first
                                % change order of interlacing by changing order of
                                % elements in dataChan array
    opt.invertCh            = 0;    % 1 = invert, 0 = do not invert
    opt.mergeCh             = 1;    % 1 = merge data, 0 = do not merge data
    opt.subtract50          = 1;    % subtract lowpass of 100Hz cutoff (put in single channel sampling rate here!)

binToBin(pathToDataFolder,dataNames,overwriteFiles,dataCh,nChDesired,opt)