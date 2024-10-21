import 'package:flutter/material.dart';

abstract class PostState {
  List<dynamic> posts;

  PostState(this.posts);
}

class PostLoaded extends PostState {
  PostLoaded(List<dynamic> posts) : super(posts);
}

class PostLoading extends PostState {
  PostLoading() : super([]);
}


class InitPostState extends PostState {
  InitPostState() : super([]);
}