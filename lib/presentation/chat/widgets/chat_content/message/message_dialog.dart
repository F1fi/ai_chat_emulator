import 'package:flutter/cupertino.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required this.onDeletePressed,
    required this.onResendPressed,
  });

  final VoidCallback onResendPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.maybeOf(context);

    final titleStyle = TextStyle(fontSize: 24);
    final style = TextStyle(fontSize: 16);

    return CupertinoAlertDialog(
      title: Text('Message sending failed.', style: titleStyle),
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            onResendPressed();
            nav?.pop();
          },
          child: Text('Resend it!', style: style),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            onDeletePressed();
            nav?.pop();
          },
          child: Text('Delete it!', style: style),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            nav?.pop();
          },
          child: Text('Cancel', style: style),
        ),
      ],
    );
  }
}
