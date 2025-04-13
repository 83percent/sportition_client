class JoinDTO {
  late String email;
  late String password;
  late String userName;
  late String gender = "unset";

  JoinDTO();

  set setEmail(String email) {
    this.email = email;
  }

  set setPassword(String password) {
    this.password = password;
  }

  set setUserName(String userName) {
    this.userName = userName;
  }

  set setGender(String gender) {
    this.gender = gender;
  }
}
