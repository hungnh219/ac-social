import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
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
                      child: const Text('Gallery'),
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Camera'),
                      onPressed: () {
                        _pickImageFromCamera();
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