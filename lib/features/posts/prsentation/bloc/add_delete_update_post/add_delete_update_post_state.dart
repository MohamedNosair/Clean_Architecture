part of 'add_delete_update_post_bloc.dart';

@immutable
sealed class AddDeleteUpdatePostState {}

final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;
  ErrorAddDeleteUpdatePostState({required this.message});
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;
  MessageAddDeleteUpdatePostState({required this.message});
}
