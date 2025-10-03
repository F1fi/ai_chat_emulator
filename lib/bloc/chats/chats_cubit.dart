import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/data/chat/chat_repository.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({required ChatRepository chatRepository})
    : _chatRepository = chatRepository,
      super(ChatsState());

  final ChatRepository _chatRepository;

  void init() async {
    final response = await _chatRepository.loadChats();

    response.when(
      onSuccess: (value) {
        emit(state.copyWith(chats: value));
        return value;
      },
    );

    emit(state.copyWith(isInitialized: true));
  }
}
