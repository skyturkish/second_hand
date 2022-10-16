import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/services/chat/chat_service.dart';

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
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: const InputDecoration(hintText: 'buraya yaz'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "you can't send empty message";
                }
                return null;
              },
            ),
          ),
          IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ChatCloudFireStoreService.instance.sendTextMessage(
                    senderUserInformation: widget.senderUserInformation,
                    receiverUserInformation: widget.receiverUserInformation,
                    text: messageController.text,
                    product: widget.product,
                  );
                  messageController.clear();
                }
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
