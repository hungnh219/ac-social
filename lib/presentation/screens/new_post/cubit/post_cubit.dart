import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  void createImagePost(File image) {
    // print('check');
    // print('image: $image');
    emit(PostWithImage(image));
  }
}