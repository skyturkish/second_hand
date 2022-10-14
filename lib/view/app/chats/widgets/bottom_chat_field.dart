import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/chat/chat_service.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField(
      {Key? key, required this.receiverUserInformation, required this.senderUserInformation, required this.product})
      : super(key: key);
  final UserInformation receiverUserInformation;
  final UserInformation senderUserInformation;
  final Product product;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  late final TextEditingController messageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: messageController,
              decoration: const InputDecoration(hintText: 'buraya yaz'),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              // await olabilir de olmayabilir de 2'sini de denersin
              await ChatCloudFireStoreService.instance.sendTextMessage(
                senderUserInformation: widget.senderUserInformation,
                receiverUserInformation: widget.receiverUserInformation,
                text: messageController.text,
                product: widget.product,
              );
              messageController.clear();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
