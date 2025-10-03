import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/chat/chat_cubit.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_content/message/message_container.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_loader.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChatCubit>();
    final messages = cubit.state.messages.reversed.toList();

    final isLoading = cubit.state.isWaitingForMessage;

    return ListView.separated(
      padding: EdgeInsets.all(8),
      reverse: true,
      itemCount: messages.length + isLoading.toInt(),
      itemBuilder: (context, index) {
        if (isLoading && index == 0) {
          return Align(alignment: Alignment.centerLeft, child: ChatLoader());
        }

        final message = messages[index - isLoading.toInt()];

        return MessageContainer(model: message);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}

extension on bool {
  int toInt() => switch (this) {
    true => 1,
    _ => 0,
  };
}
