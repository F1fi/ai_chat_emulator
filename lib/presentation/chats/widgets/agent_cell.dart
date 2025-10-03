import 'package:flutter/material.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';
import 'package:skelar_chat_emulator/presentation/shared/avatar_container.dart';

class AgentChatCell extends StatelessWidget {
  const AgentChatCell({
    super.key,
    required this.model,
    required this.onPressed,
  });

  final ChatModel model;
  final VoidCallback onPressed;

  static const _nameStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const _messageStyle = TextStyle(fontSize: 14);

  static const _radius = BorderRadius.all(Radius.circular(16.0));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: _radius,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey, borderRadius: _radius),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarContainer(url: model.agent.imageUrl),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.agent.name, style: _nameStyle),
                    Text(
                      model.lastMessage ?? 'Start new chat!',
                      style: _messageStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.chevron_right, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
