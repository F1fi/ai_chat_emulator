import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/auth/auth_cubit.dart';
import 'package:skelar_chat_emulator/bloc/chat/chat_cubit.dart';
import 'package:skelar_chat_emulator/bloc/chats/chats_cubit.dart';
import 'package:skelar_chat_emulator/data/auth/auth_local_repository.dart';
import 'package:skelar_chat_emulator/data/chat/local_chat_repository.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';
import 'package:skelar_chat_emulator/presentation/auth/auth_page.dart';
import 'package:skelar_chat_emulator/presentation/chat/chat_page.dart';
import 'package:skelar_chat_emulator/presentation/chats/chats_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const authRoute = 'authRoute';
  static const chatsRoute = 'chatsRoute';
  static const chatRoute = 'chatRoute';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navKey = GlobalKey<NavigatorState>();

  final authCubit = AuthCubit(AuthLocalRepository());

  bool isAuthorized = false;

  @override
  void initState() {
    super.initState();

    authCubit.stream.listen(_listener);
  }

  void _listener(AuthState state) {
    if (isAuthorized == state.isAuthorized) return;

    if (isAuthorized) {
      navKey.currentState?.popUntil(
        (route) => route.settings.name == MyApp.chatsRoute,
      );
      navKey.currentState?.pushReplacementNamed(MyApp.authRoute);
    } else {
      navKey.currentState?.pushReplacementNamed(MyApp.chatsRoute);
    }

    isAuthorized = state.isAuthorized;
  }

  @override
  void dispose() {
    authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: MaterialApp(
        navigatorKey: navKey,
        routes: {
          MyApp.authRoute: (_) => AuthPage(),
          MyApp.chatsRoute:
              (_) => BlocProvider(
                create:
                    (context) =>
                        ChatsCubit(chatRepository: LocalChatRepository()),
                child: ChatsPage(),
              ),
          MyApp.chatRoute: (context) {
            final chat =
                ModalRoute.of(context)!.settings.arguments as ChatModel;

            return BlocProvider(
              create:
                  (context) => ChatCubit(
                    chatModel: chat,
                    repository: LocalChatRepository(),
                  ),
              child: ChatPage(),
            );
          },
        },
        initialRoute: MyApp.authRoute,
        title: 'Flutter Demo',
        home: ChatPage(),
      ),
    );
  }
}
