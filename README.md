# Stop Sign Detection with Fine-tuned RCNN (MATLAB)

This repository contains MATLAB code for implementing a stop sign detection system using a fine-tuned RCNN model. Below is a breakdown of the functionalities provided:

## Training Script:

### Load Data:
- **load gTruth.mat**: Loads ground truth data containing bounding box information and labels for stop signs in your training dataset.
- **load('rcnnStopSigns.mat', 'layers')**: Loads a pre-trained RCNN model architecture stored in the `rcnnStopSigns.mat` file.

### Define Training Options:
- **trainingOptions('sgdm', ...)**: Sets the training optimizer to stochastic gradient descent (sgdm).
- Other options define hyperparameters for training, including:
  - **'MiniBatchSize', 32**: Batch size of images used for training updates.
  - **'InitialLearnRate', 1e-6**: Initial learning rate for adjusting model weights.
  - **'MaxEpochs', 2**: Maximum number of times to iterate through the entire training dataset.
  - **'ExecutionEnvironment', 'gpu'**: Leverages GPU for faster training (if available).

### Train RCNN Model:
- **trainRCNNObjectDetector(gTruth, layers, Options, 'NegativeOverlapRange', [0 0.1])**: Trains the RCNN object detector.
  - `gTruth`: Ground truth data for stop signs.
  - `layers`: Pre-trained RCNN model architecture.
  - `Options`: Training options defined earlier.
  - **'NegativeOverlapRange', [0 0.1]**: Defines the range of bounding box overlaps considered negative examples during training (boxes with less than 10% overlap with a ground truth stop sign are considered negative).

## Testing Script:

### Load Test Image:
- **uigetfile**: Prompts the user to select a test image.
- **imread**: Reads the selected image into the workspace.

### Stop Sign Detection:
- **detect(rcnn, img, 'MiniBatchSize', 32)**: Uses the trained RCNN model (`rcnn`) to detect stop signs in the test image (`img`). It also specifies a mini-batch size of 32 for efficient processing during detection.
  - The output includes:
    - `bbox`: Bounding boxes around detected stop signs.
    - `score`: Confidence scores for each detection (probability of being a stop sign).
    - `label`: Labels for each detection (should be 'stop sign' in this case).

### Filter and Visualize Results:
- **nobox=size(score, 1)**: Counts the number of detected objects.
- **scorebox=[score, bbox]**: Combines confidence scores with bounding box information.
- **scorebox = sortrows(scorebox, 'descend')**: Sorts detections by confidence score (highest score first).
- The code iterates through detections and displays only those with a confidence score above a threshold (e.g., 0.95). It then visualizes the test image with bounding boxes and confidence scores for detected stop signs.

## Additional Notes:

- This is a basic implementation. You can modify it to:
  - Train the model for a longer duration or with different hyperparameters for better accuracy.
  - Evaluate the model's performance on a separate validation dataset.
  - Integrate this code into a larger application for real-time stop sign detection in video streams.
