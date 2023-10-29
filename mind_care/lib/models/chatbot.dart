class ChatMessage {
  final String message;
  final Role role;

  ChatMessage(this.message, {required this.role});
}

enum Role {
  system,
  user,
  bot,
}
