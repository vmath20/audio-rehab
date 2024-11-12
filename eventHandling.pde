class Example implements NotificationListener {
  public Example() {
    
  }
  public void notificationReceived(Notification notification) {
     println("<Example>" + notification.getType().toString() + "notification received at " + Integer.toString(notification.getTimestamp()) + " ms");
     
     String debugOutput = ">>> ";
             switch (notification.getType()) {
            case dynamic:
                debugOutput += "Motion Type: ";
                if (!minInv) {
                    switch (notification.getMotionType()) {
                        case "swipeLeft":
                            leftSlider.setValue(notification.getMotionLevel());
                            leftSlider(notification.getMotionLevel());
                            break;
                        case "swipeRight":
                            rightSlider.setValue(notification.getMotionLevel());
                            rightSlider(notification.getMotionLevel());
                            break;
                        case "swipeUp":
                            upSlider.setValue(notification.getMotionLevel());
                            upSlider(notification.getMotionLevel());
                            break;
                        case "swipeDown":
                            downSlider.setValue(notification.getMotionLevel());
                            downSlider(notification.getMotionLevel());
                            break;
                        case "thumbsUp":
                            playAudioVisual("thumbsUp");
                            break;
                        case "thumbsDown":
                            playAudioVisual("thumbsDown");
                            break;
                        case "peaceSign":
                            playAudioVisual("peaceSign");
                            break;
                        case "closedFist":
                            playAudioVisual("closedFist");
                            break;
                        case "openPalm":
                            playAudioVisual("openPalm");
                            break;
                        default:
                            break;
                    }
                }
         case leftHand:
           alignmentSlider.setValue(notification.getPercent());
           alignmentSlider(notification.getPercent());
           align();
           break;
         case rightHand:
           GainSlider.setValue(notification.getZpos() * 80);
           GainSlider(notification.getZpos() * 80);
           xyGrid.setValue(notification.getXpos(), notification.getYpos());
           xyGrid();
     }
     debugOutput += notification.toString();
  }
  private void playAudioVisual(String motionType) {
        String audioFileName = motionType + ".wav";
        SamplePlayer audioPlayer = getSamplePlayer(audioFileName);
        ac.out.addInput(audioPlayer);
        //audioPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
        audioPlayer.start();
    }
  
}
