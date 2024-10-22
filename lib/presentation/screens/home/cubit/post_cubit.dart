import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/home/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(InitPostState());

  Future<void> getPosts() async {
    emit(PostLoading());
    // final posts = await postRepository.getPosts();
    // emit(PostLoaded(posts));
  }
}