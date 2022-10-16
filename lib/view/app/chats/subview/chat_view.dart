import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';
import 'package:second_hand/view/app/chats/widgets/chat_list.dart';
import 'package:second_hand/view/app/chats/widgets/bottom_chat_field.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.productId, required this.contactUserId});
  final String productId;
  final String contactUserId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Product? product;
  UserInformation? contactUserInformation;

  @override
  void initState() {
    getProductAndInformation();
    super.initState();
  }

  Future<void> getProductAndInformation() async {
    product = await ProductCloudFireStoreService.instance.getProductById(productId: widget.productId);

    contactUserInformation =
        await UserCloudFireStoreService.instance.getUserInformationById(userId: widget.contactUserId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: product == null || contactUserInformation == null
          ? const Center(child: LottieAnimationView(animation: LottieAnimation.messageChat))
          : Column(
              children: [
                Expanded(
                  child: ChatListView(
                    productImage: product!.imagesPath.first,
                    productId: product!.productId,
                    receiverUserInformation: contactUserInformation!,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                BottomChatField(
                  receiverUserInformation: contactUserInformation!,
                  senderUserInformation: context.read<UserInformationNotifier>().userInformation,
                  product: product!,
                ),
              ],
            ),
    );
  }
}
