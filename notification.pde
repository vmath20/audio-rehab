enum NotificationType { dynamic, leftHand, rightHand }

class Notification {
   
  int timestamp;
  NotificationType type;
  String motionType;
  float motionLevel;
  String flag;
  int priority;
  float percent;
  float xpos;
  float ypos;
  float zpos;
  
  public Notification(JSONObject json) {
    this.timestamp = json.getInt("timestamp");    
    String typeString = json.getString("type");
    try {
      this.type = NotificationType.valueOf(typeString);
    }
    catch (IllegalArgumentException e) {
      throw new RuntimeException(typeString + " is not a valid value for enum NotificationType.");
    }
    this.priority = json.getInt("priority");
    
    switch(type) {
       case dynamic:
         if (json.isNull("motionType")) {
           this.motionType = "";
         }
         else {
           this.motionType = json.getString("motionType");
         }
         if (json.isNull("motionLevel")) {
            this.motionLevel = 0.0;
         }
         else {
           this.motionLevel = json.getFloat("motionLevel");
         }
         if (json.isNull("flag")) {
           this.flag = "";
         }
         else {
           this.flag = json.getString("flag");
         }
         break;
      case leftHand:
         if (json.isNull("percent")) {
           this.percent = 0.0;
         }
         else {
           this.percent = json.getFloat("percent");
         }
         if (json.isNull("flag")) {
           this.flag = "";
         }
         else {
           this.flag = json.getString("flag");
         }
         break;
      case rightHand:
         if (json.isNull("xpos")) {
           this.xpos = 0.0;
         }
         else {
           this.xpos = json.getFloat("xpos");
         }
         if (json.isNull("ypos")) {
           this.ypos = 0.0;
         }
         else {
           this.ypos = json.getFloat("ypos");
         }
         if (json.isNull("zpos")) {
           this.zpos = 0.0;
         }
         else {
           this.zpos = json.getFloat("zpos");
         }
         break;
    }
  }
  public int getTimestamp() { return timestamp; }
  public NotificationType getType() { return type; }
  public String getMotionType() { return motionType; }
  public float getMotionLevel() { return motionLevel; }
  public String getFlag() { return flag; }
  public float getPercent() { return percent; }
  public float getXpos() { return xpos; }
  public float getYpos() { return ypos; }
  public float getZpos() { return zpos; } 
  public int getPriorityLevel() { return priority; }

  public String toString() {
      String output = getType().toString() + ": ";
      output += "(priority: " + getPriorityLevel() + ") ";
      switch(type) {
        case dynamic:
          output += "(motionType: " + getMotionType() + ") ";
          output += "(motionLevel: " + getMotionLevel() + ") ";
          output += "(flag: " + getFlag() + ") ";
          break;
        case leftHand:
          output += "(percent: " + getPercent() + ") ";
          output += "(flag: " + getFlag() + ") ";
          break;
        case rightHand:
          output += "(xpos: " + getXpos() + ") ";
          output += "(ypos: " + getYpos() + ") ";
          output += "(zpos: " + getZpos() + ") ";
          break;
      }
      return output;
    }
}
