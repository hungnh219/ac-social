import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_state.dart';
import 'package:social_app/service_locator.dart';

class ActionPost extends StatefulWidget {
  const ActionPost({super.key});

  @override
  State<ActionPost> createState() => _ActionPostState();
}

class _ActionPostState extends State<ActionPost> {
  late PostCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _postCubit = context.read<PostCubit>();
  }

  @override
  void dispose() {
    _postCubit.close();
    super.dispose();
  }

  Future _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // add image to bloc
      _postCubit.createImagePost(File(pickedFile.path));
    }
  }

  Future _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // add image to bloc
      _postCubit.createImagePost(File(pickedFile.path));
    }
  }

  Future _uploadPost() async {
    // upload post to firestore
    // await sl<FirestoreService>().uploadPost();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Icon(Icons.image, color: Colors.blueAccent,),
              SizedBox(width: 8),
              Text('Photo', style: TextStyle(color: Colors.red),),
          Spacer(),
        ],
      ),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 400,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      child: const Text('Gallery', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Camera', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        _pickImageFromCamera();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('upload', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        // _uploadImage();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}