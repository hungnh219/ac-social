import 'dart:io';

abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostWithImage extends PostState {
  final File image;
  // final String caption;
  PostWithImage(this.image);
}

class PostWithoutImage extends PostState {
  // final String caption;

  const PostWithoutImage();
}