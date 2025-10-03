import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/chat/chat_cubit.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_footer/chat_field.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_footer/send_button.dart';

class ChatFooter extends StatefulWidget {
  const ChatFooter({super.key});

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ChatField(controller: controller)),
        SizedBox(width: 10),
        SendButton(onPressed: onPressed),
      ],
    );
  }

  Future<void> onPressed() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    final cubit = context.read<ChatCubit>();
    cubit.sendMessage(text);
    controller.clear();
  }
}
