class UserDTO {
  final String uid;
  final String userName;
  String? imageId;
  final String gender;
  String? description;

  final String centerUID;

  UserDTO({
    required this.uid,
    required this.userName,
    required this.gender,
    this.description,
    required this.centerUID,
    this.imageId,
  });
}
