%% Wrapper File for Extracting Information from Binary files & Sorting Program Outputs
%% Add Functions to Path
addpath(genpath('C:\PATH\TO\THE\REPO\ephys-pipeline\MATLAB-Analysis\Spike'))
%% Extracts spike times to _sortedmat
sortedType = 'kilosort';
sortOutputFolder = 'C:\PATH\TO\THE\SORTED\FOLDER\181108\preAutoMerge';
file = '181108';
startTrial = 1;
csvName = [];
clusterType = 'unsorted';
filename.sortOutput= extractTrialUnits(sortedType,...           % sorting Program used
                                       sortOutputFolder, ...    % location of sorting output
                                       file, ....               % ['YYMMDD' ; 'XYZ.kwik'] - XYZ.kwik is only if you are using klusta
                                       startTrial, ...          % YYMMDD_X - where is is starting number
                                       csvName, ...             % Name of merge_info csv
                                       clusterType);            % ['XYZ' ; 'ABC'] - rows containing different cluster types to keep - note: depends on your manual clustering - leave empty if you want to keep all of them

filename.sortOutput = [sortOutputFolder, filename.sortOutput];   
%% Establish Metafile struct
filename.raw=['C:\PATH\TO\THE\BINARY\150526\Tetrode test data\150526__MovingObjects_1.bin'];
filename.sortOutput=['C:\PATH\TO\THE\SORTED\OUTPUT\150526\Tetrode test data\150526_01_sorted.mat'];

%%% IF YOU HAVE A .meta FILE
    [m, fpath, mfile] = readMetafile2('150526__MovingObjects_1.meta','C:\PATH\TO\THE\METAFILE\150526\Tetrode test data\');
    % [m, fpath, mfile] = readMetafile(); % GUI version
    m.metafile = mfile;
    m.metapath = fpath;
%%%

%%% IF YOU DO NOT HAVE A .meta FILE
    % m.nChans = 2;       % number of channels
    % m.sRateHz = 30e3;   % sampling frequency
%%%
m.pdch      = m.nChans; %assume pd is last ch
m.ech       = 1:m.nChans-1; % ephys channel(s) is everything except the last
m.dbytes    = 2; % byte size of data - i.e. int16 is 2 bytes
m.msec      = m.sRateHz/1000; % conversion factor from ms time to sample number

%% Extract Waveforms
[m,s] = extractTrialUnitWaves(filename.raw, ... % Binary File
                      filename.sortOutput, ...  % _sorted.mat file
                      m, ...                    % metafile struct, m
                      []);              % filename to store output, leave as [] if you don't want to save
                                   
%% Extract PD data
m.fps = 360; % (projector frame rate)*3  (*3 for RGB)
% m.pdthr = 3e3; % Can set now, or comment out to set graphically in function 
m.pdthr = 3; % Daniel's data 
[m] = extractTrialADC_PD(filename.raw, ... % Binary File
                        m, ....     % metafile struct, m
                        'test.mat' ); % filename to store output, leave as [] if you don't want to save
                                   
