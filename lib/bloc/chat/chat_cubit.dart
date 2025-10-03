import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/data/chat/chat_repository.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';
import 'package:skelar_chat_emulator/models/message/message_model.dart';
import 'package:skelar_chat_emulator/models/message/message_status.dart';
import 'package:skelar_chat_emulator/models/message/local_message_model.dart';
import 'package:skelar_chat_emulator/models/message/message_base_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required ChatModel chatModel, required ChatRepository repository})
    : _repository = repository,
      super(ChatState(chatModel: chatModel));

  final ChatRepository _repository;

  void init() async {
    final response = await _repository.loadMessagesByChatId(state.chatModel.id);

    response.when(
      onSuccess: (value) {
        emit(state.copyWith(sentMessages: value.cast<MessageBaseModel>()));

        return value;
      },
    );

    emit(state.copyWith(isInitialized: true));
  }

  void sendMessage(String text) async {
    final message = LocalMessageModel(text: text, chatId: state.chatModel.id);
    final list = state.pendingMessages.toList();

    list.add(message);
    emit(state.copyWith(pendingMessages: list));

    final response = await _repository.sendMessage(message);

    final pending = state.pendingMessages.toList()..removeAt(0);
    final sentMessages = state.sentMessages.toList();

    response.when(
      onSuccess: (answer) {
        final newMessageId = answer.toMessageId;

        sentMessages.addAll([
          if (newMessageId == null)
            LocalMessageModel(
              text: text,
              status: MessageStatus.sent,
              chatId: state.chatModel.id,
            )
          else
            MessageModel(
              id: newMessageId,
              text: text,
              isOwner: true,
              chatId: state.chatModel.id,
            ),
          answer,
        ]);

        return answer;
      },
      onFail: (error) {
        sentMessages.add(
          LocalMessageModel(
            text: text,
            status: MessageStatus.canceled,
            chatId: state.chatModel.id,
          ),
        );

        return null;
      },
    );

    emit(state.copyWith(pendingMessages: pending, sentMessages: sentMessages));
  }

  void deleteCanceledMessage(MessageBaseModel message) {
    if (message.status != MessageStatus.canceled) return;
    final sentMessages = state.sentMessages..remove(message);
    emit(state.copyWith(sentMessages: sentMessages));
  }

  void resendCanceledMessage(MessageBaseModel message) {
    if (message.status != MessageStatus.canceled) return;
    deleteCanceledMessage(message);
    sendMessage(message.text);
  }
}
