import 'package:skelar_chat_emulator/models/message/message_base_model.dart';
import 'package:skelar_chat_emulator/models/message/message_status.dart';

class LocalMessageModel extends MessageBaseModel {
  const LocalMessageModel({
    required this.text,
    required this.chatId,
    this.status = MessageStatus.pending,
  });

  @override
  final String chatId;

  @override
  final String text;

  @override
  final MessageStatus status;

  @override
  bool get isOwner => true;
}
