import 'package:flutter/material.dart';

class ChatLoader extends StatefulWidget {
  const ChatLoader({super.key});

  @override
  State<ChatLoader> createState() => _ChatLoaderState();
}

class _ChatLoaderState extends State<ChatLoader>
    with SingleTickerProviderStateMixin {
  static const size = 8.0;

  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1, milliseconds: 500),
    )..repeat();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 28,
      child: AnimatedBuilder(
        animation: controller!,

        builder: (context, _) {
          final value = controller?.value ?? 0;
          final int index;

          if (value < 0.33) {
            index = 0;
          } else if (value < 0.66) {
            index = 1;
          } else {
            index = 2;
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.only(bottom: index == 0 ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white30,
                ),
                width: size,
                height: size,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.only(
                  bottom: index == 1 ? 4 : 0,
                  left: 4,
                  right: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white30,
                ),
                width: size,
                height: size,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.only(bottom: index == 2 ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white30,
                ),
                width: size,
                height: size,
              ),
            ],
          );
        },
      ),
    );
  }
}
