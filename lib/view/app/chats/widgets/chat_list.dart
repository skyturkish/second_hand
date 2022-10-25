import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/message.dart';
import 'package:second_hand/models/user_information.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/chat/chat_service.dart';
import 'package:second_hand/view/app/chats/widgets/my_message_card.dart';
import 'package:second_hand/view/app/chats/widgets/sender_message_card.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({
    Key? key,
    required this.receiverUserInformation,
    required this.productId,
    required this.productImage,
  }) : super(key: key);
  final UserInformation receiverUserInformation;
  final String productId;
  final String productImage;
  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  late final ScrollController messageController;

  @override
  void initState() {
    messageController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            NavigationService.instance
                .navigateToPage(path: NavigationConstants.ACCOUNT_DETAIL, data: widget.receiverUserInformation);
          },
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(widget.productImage),
                  ),
                  CircleAvatar(
                      radius: 10, backgroundImage: NetworkImage(widget.receiverUserInformation.profilePhotoPath)),
                ],
              ),
              Padding(
                padding: context.paddingOnlyLeftSmallX,
                child: Text(
                  widget.receiverUserInformation.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<Message>>(
        stream: ChatCloudFireStoreService.instance.getChatStream(
          productId: widget.productId,
          senderId: AuthService.firebase().currentUser!.id,
          receiverId: widget.receiverUserInformation.userId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Auto scroll view
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController.jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];

              final timeSent = DateFormat.Hm().format(messageData.timeSent);

              // set message as seen
              if (!messageData.isSeen && messageData.receiverId == AuthService.firebase().currentUser!.id) {
                ChatCloudFireStoreService.instance.setChatMessageSeen(
                  messageId: messageData.messageId,
                  productId: widget.productId,
                  receiverUserId: messageData.receiverId,
                  senderUserId: messageData.senderId,
                );
              }

              if (messageData.senderId == AuthService.firebase().currentUser!.id) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
                isSeen: messageData.isSeen,
              );
            },
          );
        },
      ),
    );
  }
}
