enum RoleType {
  ROLE_HEADMASTER,
  ROLE_DEPUTY_HEAD
}


extension ParseToString on RoleType {
  String formattedToString(){
    return this.toString().split(".")[1];
  }
}
