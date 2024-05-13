% Load the pretrained layers
load gTruth.mat
load('rcnnStopSigns.mat', 'layers');


% Define training options with GPU processing
Options = trainingOptions('sgdm', ...
    'MiniBatchSize', 32, ...
    'InitialLearnRate', 1e-6, ...
    'MaxEpochs', 2, ...
    'ExecutionEnvironment', 'gpu'); % Specify GPU as the execution environment

% Train RCNN with separate training and validation data
rcnn = trainRCNNObjectDetector(gTruth, layers, Options, 'NegativeOverlapRange', [0 0.1]);
