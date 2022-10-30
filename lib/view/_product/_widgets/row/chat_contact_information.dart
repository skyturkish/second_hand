import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/chat_contact.dart';
import 'package:second_hand/services/chat/chat_service.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';
import 'package:second_hand/view/_product/enums/chat_contact_type_enum.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';

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
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const LottieAnimationView(animation: LottieAnimation.loading);
            case ConnectionState.active:
              if (!snapshot.hasData) {
                return Text(context.loc.hasNoData);
              } else {
                final chatContacts = snapshot.data as Iterable<ChatContact>;
                return chatContacts.isEmpty
                    ? Center(
                        child: Text(
                          context.loc.thereIsNoChat,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      )
                    : ListView.builder(
                        itemCount: chatContacts.length,
                        itemBuilder: (context, index) {
                          final chatContactData = snapshot.data.toList()[index] as ChatContact;
                          return InkWell(
                            onTap: () {
                              NavigationService.instance.navigateToPage(
                                path: NavigationConstants.CHAT_VIEW,
                                data: [chatContactData.productId, chatContactData.receiverId],
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
                                    backgroundImage: NetworkImage(chatContactData.receiverProfilePictureURL),
                                  ),
                                ],
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: context.paddingOnlyBottomSmall / 3,
                                    child: Text(
                                      chatContactData.receiverName.overFlowString(limit: 20),
                                      style: Theme.of(context).textTheme.headline6!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: context.colors.onBackground,
                                          ),
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
                              subtitle: Row(
                                children: [
                                  Text(
                                    chatContactData.lastMessage.overFlowString(limit: 30),
                                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.Hm().format(chatContactData.timeSent),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ChatCloudFireStoreService.instance.deleteChatContact(
                                          productId: chatContactData.productId,
                                          senderId: chatContactData.senderId,
                                          receiverId: chatContactData.receiverId,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }
          }
        },
      ),
    );
  }
}
