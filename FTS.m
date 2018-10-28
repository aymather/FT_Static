% % % % % % % % % % % % % % % % % % % % % % % % % % 
% 
% Program Written By: Alec Mather
% Post_Doc in charge: QiYang Nei
% Professor in charge: Jan Wessel
%
% Oct. 2018
% Matlab 2017b/Psychtoolbox
%
% % % % % % % % % % % % % % % % % % % % % % % % % % 

% Safety Check
clear;clc
commandwindow;

% MacOS Specific
Screen('Preference', 'SkipSyncTests', 1);

% INITIALIZE
addpath(genpath(fileparts(which('FTS.m'))));

% Get Data
data = FT_data;

% Init
settings = FT_init(data);

% Generate trialseq
trialseq = FT_sequence(settings,id,data);

% Go through trials
trialseq = FT_backend(settings,trialseq,id);

% Provide feedback values
[loc_values, glob_values] = FT_calcFeedback(trialseq,id);

% Save
save(fullfile(settings.outfolder,settings.outfile),'trialseq','settings', 'loc_values', 'glob_values');