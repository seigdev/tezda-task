import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class UploadProfilePicture extends StatefulWidget {
  const UploadProfilePicture({super.key});

  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture>
    with AppThemeMixin {
  File? _image;

  bool loading = false;

  final _storage = FirebaseStorage.instance;

  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage();
      } else {
        showErrorToast("No Image Selected");
        log('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    setState(() => loading = true);
    if (_image == null) return;

    try {
      final ref = _storage.ref().child('profile_pictures/${UserModel.userId}');
      final uploadTask = ref.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update FirebaseAuth profile
      await _auth.currentUser!.updateProfile(photoURL: downloadUrl);

      // Update user collection data
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'profile_picture': downloadUrl,
      });
      setState(() => loading = false);
      showSuccessToast("Image Uploaded Successfully");
    } catch (e) {
      setState(() => loading = false);
      showErrorToast("Image Uploaded Successfully");
      log('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Spacings.spacing10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Spacings.spacing20),
              border: Border.all(
                color: colors.ggray400,
              ),
            ),
            child: const BaseText(
              'Upload Picture',
              fontWeight: FontWeight.w600,
            ),
          ),
          const HSpacer(Spacings.spacing20),
          loading
              ? CircularLoadingComponent(
                  color: colors.tF9A03F,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
