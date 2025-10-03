import 'package:skelar_chat_emulator/models/agent/agent_model.dart';

class ChatModel {
  const ChatModel({
    required this.id,
    required this.agent,
    required this.userId,
    required this.lastMessage,
  });

  final String id;
  final AgentModel agent;
  final String userId;
  final String? lastMessage;
}
