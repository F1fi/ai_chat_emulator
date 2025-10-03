part of 'chats_cubit.dart';

class ChatsState {
  const ChatsState({this.isInitialized = false, this.chats = const []});

  final bool isInitialized;
  final List<ChatModel> chats;

  ChatsState copyWith({bool? isInitialized, List<ChatModel>? chats}) {
    return ChatsState(
      isInitialized: isInitialized ?? this.isInitialized,
      chats: chats ?? this.chats,
    );
  }
}
