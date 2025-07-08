// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<ConversationModel> conversations;
  ConversationLoaded(this.conversations);
}

class ConversationEmpty extends ConversationState {}

class ConversationError extends ConversationState {
  final String message;
  ConversationError(this.message);
}

class ConversationAddSuccess extends ConversationState {
  final ConversationModel conversation;
  ConversationAddSuccess({
    required this.conversation,
  });
}

class ConversationAddFailure extends ConversationState {
  final String message;
  ConversationAddFailure(this.message);
}

class ConversationEditSuccess extends ConversationState {}

class ConversationEditFailure extends ConversationState {
  final String errMessage;
  final dynamic errors;
  ConversationEditFailure(this.errMessage, this.errors);
}

class ConversationDeleteSuccess extends ConversationState {}

class ConversationDeleteFailure extends ConversationState {
  final String message;
  ConversationDeleteFailure(this.message);
}


class MemeberDeleteSuccess extends ConversationState {}

class MemeberDeleteFailure extends ConversationState {
  final String errMessage;
  final dynamic errors;
  MemeberDeleteFailure(this.errMessage, this.errors);
}


