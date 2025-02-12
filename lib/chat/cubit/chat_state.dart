 class ChatState {}

final class ChatInitial extends ChatState {}
final class ChangeTabState extends ChatState {}
final class MessageSentSuccess extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
final class UsersLoaded extends ChatState {
  final List<Map<String, dynamic>> users;

  UsersLoaded(this.users);
}
