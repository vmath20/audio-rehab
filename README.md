# Stroke Rehabilitation Hand Gesture Detection Simulator

## Overview
This project is a hand gesture detection simulator specifically designed for stroke rehabilitation therapy. The simulator provides real-time audio feedback based on hand movements, allowing users to engage in exercises that assist with neuromotor recovery. This system aims to enhance user motivation and engagement by transforming rehabilitation exercises into an interactive and enjoyable experience.

## Features
- **Real-Time Gesture Detection**: Detects nine different hand gestures to align with stroke rehabilitation exercises.
- **Sonification for Feedback**: Uses audio synthesis (sine and square waves) to provide immediate feedback based on hand movement.
- **Visual and Audio Cues**: Displays visual sliders and sound cues to guide exercises.
- **Background Music Options**:
  - **Band Music**: Background track with adjustable volume for practice.
  - **Saxophone Loop**: Reverb-filtered loop to provide rhythm and practice support.
- **2D Hand Position Tracking**: Maps the right hand’s position in 2D space.
- **Text-to-Speech Warnings**: Alerts users if their body angle needs adjustment.

## Getting Started

### Prerequisites
- **Processing IDE**: Required for executing `.pde` files.
- **Audio and Text-to-Speech Libraries**: Ensure that necessary libraries for audio playback and TTS (Text-to-Speech) are installed in Processing.

### Environment Setup
1. **Clone this Repository**:
   ```bash
   git clone https://github.com/yourusername/stroke-rehabilitation-simulator.git
   ```
2. **Open the Project in Processing**: Launch the Processing IDE and open the main `.pde` file to begin.
3. **Install Required Libraries**:
   - Use the Processing library manager to install necessary sound libraries.
   - Verify that text-to-speech capabilities are enabled for the simulator to provide auditory feedback.

### Running the Simulator
1. **Initialize Exercise Test**:
   - Click on the **Exercise Test 1** button to begin a sample video, which will initiate gesture recognition and automatic adjustments.
2. **Use Manual Sliders**:
   - Observe automatic adjustments as gestures are detected, or manually adjust sliders to experiment with different feedback.
3. **Play Background Music**:
   - Enable **Band Music** and control the volume, or click **Saxophone** for a rhythmic loop.
4. **Monitor Body Position**:
   - The **Body Position** button provides a text-to-speech alert if an incorrect body angle is detected during exercise.

## File Structure
- **notification.pde**: Handles notifications within the simulator.
- **text_to_speech.pde**: Integrates text-to-speech for vocal feedback on body positioning.
- **notification_server.pde**: Manages notification server functions.
- **notification_listener.pde**: Listens for specified notification events.
- **notification_comparator.pde**: Compares notifications to initiate responses.
- **helper_functions.pde**: Provides support functions used across various modules.
- **eventHandling.pde**: Manages event handling for user interactions.
- **vaibhavmishra.pde**: Core logic file with main simulator functionality.

## User Guide
For a comprehensive guide on the simulator’s features and step-by-step usage instructions, please refer to the [User Manual](User%20Manual.pdf).

## Methodology
This project leverages a novel AI-based gamification approach to neuromotor therapy, focusing on enhancing traditional stroke rehabilitation exercises. The system provides multi-modal feedback, integrating both visual and auditory cues to stimulate attention and motivation.

## Contributing
Contributions are welcome! To contribute:
1. Fork this repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Make your changes and commit them.
4. Push your branch and open a pull request.

## Contact
For any questions or additional support, please contact Vaibhav Mishra at [vmishra48@gatech.edu](mailto:vmishra48@gatech.edu).
