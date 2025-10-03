import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/auth/auth_cubit.dart';
import 'package:skelar_chat_emulator/bloc/chats/chats_cubit.dart';
import 'package:skelar_chat_emulator/main.dart';
import 'package:skelar_chat_emulator/presentation/chats/widgets/agent_cell.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ChatsCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChatsCubit>();
    final chats = cubit.state.chats;

    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats for ${authCubit.state.login}'),
        leading: IconButton(
          onPressed: () {
            authCubit.signOut();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final model = chats[index];
          return AgentChatCell(
            model: model,
            onPressed: () {
              Navigator.maybeOf(
                context,
              )?.pushNamed(MyApp.chatRoute, arguments: model).then((_) {
                cubit.init();
              });
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}
