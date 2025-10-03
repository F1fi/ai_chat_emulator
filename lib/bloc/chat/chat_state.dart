part of 'chat_cubit.dart';

class ChatState {
  const ChatState({
    required this.chatModel,
    this.isInitialized = false,
    this.pendingMessages = const <MessageBaseModel>[],
    this.sentMessages = const <MessageBaseModel>[],
  });

  final bool isInitialized;
  final ChatModel chatModel;
  final List<MessageBaseModel> pendingMessages;
  final List<MessageBaseModel> sentMessages;

  bool get isWaitingForMessage => pendingMessages.isNotEmpty;

  List<MessageBaseModel> get messages => [...sentMessages, ...pendingMessages];

  ChatState copyWith({
    bool? isInitialized,
    List<MessageBaseModel>? pendingMessages,
    List<MessageBaseModel>? sentMessages,
  }) {
    return ChatState(
      chatModel: chatModel,
      isInitialized: isInitialized ?? this.isInitialized,
      pendingMessages: pendingMessages ?? this.pendingMessages,
      sentMessages: sentMessages ?? this.sentMessages,
    );
  }
}
