import 'package:skelar_chat_emulator/models/message/message_status.dart';

abstract class MessageBaseModel {
  const MessageBaseModel();

  String get chatId;
  String get text;
  bool get isOwner;
  MessageStatus get status;
}
