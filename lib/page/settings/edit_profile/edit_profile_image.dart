import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sportition_client/shared/styles/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileImage extends StatefulWidget {
  String? imageId;
  EditProfileImage({
    Key? key,
    this.imageId,
  }) : super(key: key);

  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _uploadImageToFirebase(image);
    }
  }

  Future<void> _uploadImageToFirebase(XFile image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageRef =
            FirebaseStorage.instance.ref().child('profile').child(user.uid);
        await storageRef.putFile(File(image.path));
        final imageUrl = await storageRef.getDownloadURL();
        setState(() {
          _imageUrl = imageUrl;
        });
      }
    } catch (e) {
      // Handle errors
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          /* 사용자 이미지 */
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.borderGray010Color,
              borderRadius: BorderRadius.circular(17),
              image: _imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(_imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
        Center(
          child: TextButton(
            child: const Text(
              '프로필 사진 변경',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Notosans',
              ),
            ),
            onPressed: _pickImage,
          ),
        )
      ],
    );
  }
}
