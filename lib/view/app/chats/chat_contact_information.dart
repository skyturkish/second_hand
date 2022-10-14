import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/chat_contact_type_enum.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/models/chat_contact.dart';
import 'package:second_hand/service/chat/chat_service.dart';
import 'package:second_hand/view/app/chats/subview/chat_view.dart';

class ChatContactInformation extends StatelessWidget {
  const ChatContactInformation({super.key, required this.userId, required this.chatContactType});
  final ChatContactType chatContactType;

  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Iterable<ChatContact>>(
        stream: chatContactType == ChatContactType.BUY
            ? ChatCloudFireStoreService.instance.getChatContactsToBuy(userId: userId)
            : ChatCloudFireStoreService.instance.getChatContactsToSell(userId: userId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const Center(child: Text('DONE'));

            case ConnectionState.none:
              return const Center(child: Text('NONE'));

            case ConnectionState.waiting:
              return const Center(child: Text('waiting data '));
            case ConnectionState.active:
              if (!snapshot.hasData) {
                return const Text('HAS NO DATA');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final chatContactData = snapshot.data.toList()[index] as ChatContact;
                    // olum lan bu list tile olabilirdi
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              // TODO bunu id alacak şekilde yap
                              builder: (context) => ChatView(
                                productId: chatContactData.productId,
                                contactUserId: chatContactType == ChatContactType.BUY
                                    ? chatContactData.receiverId
                                    : chatContactData.senderId,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(chatContactData.productPic),
                              ),
                              CircleAvatar(
                                  radius: 13,
                                  backgroundImage: NetworkImage(chatContactType == ChatContactType.BUY
                                      ? chatContactData.receiverProfilePictureURL
                                      : chatContactData.senderProfilePictureURL)),
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: context.paddingOnlyBottomSmall / 3,
                                child: Text(
                                  chatContactType == ChatContactType.BUY
                                      ? chatContactData.receiverName
                                      : chatContactData.senderName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: context.paddingOnlyBottomSmall / 3,
                                child: Text(
                                  chatContactData.productName,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            chatContactData.lastMessage.overFlowString(limit: 30),
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w200),
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(chatContactData.timeSent),
                          ),
                        ));
                  },
                );
              }
          }
        },
      ),
    );
  }
}
