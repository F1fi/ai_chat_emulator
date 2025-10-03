import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/chat/chat_cubit.dart';
import 'package:skelar_chat_emulator/presentation/shared/avatar_container.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_content/chat_content.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_footer/chat_footer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    context.read<ChatCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChatCubit>();
    final agent = cubit.state.chatModel.agent;

    return Scaffold(
      appBar: AppBar(
        title: Text(agent.name),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.maybeOf(context)?.maybePop();
          },
          color: Colors.black,
        ),
        actions: [AvatarContainer(url: agent.imageUrl)],
      ),
      body: Visibility(
        visible: cubit.state.isInitialized,
        replacement: Center(child: CircularProgressIndicator()),
        child: Column(
          children: [
            const Divider(height: 1, thickness: 0),
            Expanded(child: const ChatContent()),
            const Divider(height: 1, thickness: 0),
            Padding(
              padding: const EdgeInsets.all(8),
              child: const ChatFooter(),
            ),
          ],
        ),
      ),
    );
  }
}
