enum MessageStatus {
  READ,
  SENT
}

extension ParseToString on MessageStatus {
  String formattedToString(){
    return this.toString().split(".")[1];
  }
}
