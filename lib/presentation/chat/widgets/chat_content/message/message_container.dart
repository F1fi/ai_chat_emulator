import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/chat/chat_cubit.dart';
import 'package:skelar_chat_emulator/models/message/message_base_model.dart';
import 'package:skelar_chat_emulator/models/message/message_status.dart';
import 'package:skelar_chat_emulator/presentation/chat/widgets/chat_content/message/message_dialog.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, required this.model});

  final MessageBaseModel model;

  bool get _isIconVisible =>
      model.isOwner && model.status != MessageStatus.sent;

  bool get _isCanceled => model.status == MessageStatus.canceled;

  static const _radius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          model.isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (_isIconVisible)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              _isCanceled ? Icons.cancel : Icons.send,
              size: 18,
              color: _isCanceled ? Colors.red : null,
            ),
          ),
        InkWell(
          onTap: _isCanceled ? () => onPressed(context) : null,
          radius: _radius,
          borderRadius: BorderRadius.circular(_radius),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_radius),
              color: model.isOwner ? Colors.lightBlue : Colors.blueGrey,
              border:
                  _isCanceled ? Border.all(color: Colors.red, width: 2) : null,
            ),
            child: Text(model.text),
          ),
        ),
      ],
    );
  }

  void onPressed(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return MessageDialog(
          onResendPressed: () => cubit.resendCanceledMessage(model),
          onDeletePressed: () => cubit.deleteCanceledMessage(model),
        );
      },
    );
  }
}
