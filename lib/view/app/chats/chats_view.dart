import 'package:flutter/material.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  State<ChatsView> createState() => ChatsViewState();
}

class ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Chats',
        ),
      ),
    );
  }
}
