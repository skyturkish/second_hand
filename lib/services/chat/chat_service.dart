import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand/models/product/product.dart';
import 'package:second_hand/models/user_information/user_information.dart';
import 'package:second_hand/models/message/message.dart';
import 'package:second_hand/models/chat_contact/chat_contact.dart';
import 'package:second_hand/services/chat/abstract_chat_service.dart';
import 'package:uuid/uuid.dart';

class ChatCloudFireStoreService extends IChatCloudFireStoreService {
  static final ChatCloudFireStoreService instance = ChatCloudFireStoreService._internal();

  factory ChatCloudFireStoreService() {
    return instance;
  }

  ChatCloudFireStoreService._internal();
  @override
  Future<void> saveDataToContactsSubCollection({
    required UserInformation senderUserInformation,
    required UserInformation receiverUserInformation,
    required String lastMessage,
    required String productImageURL,
    required String productName,
    required String productId,
    required String productOwnerId,
    required DateTime timeSent,
  }) async {
    // The chatContactId to delete chatcontact
    final senderContactId = const Uuid().v4();
    // Let the sender user know who they are talking to, what product they are talking about, and what the latest message is.
    final senderChatContact = ChatContact(
      chatContactId: senderContactId,
      senderName: senderUserInformation.name,
      receiverName: receiverUserInformation.name,
      senderId: senderUserInformation.userId,
      receiverId: receiverUserInformation.userId,
      senderProfilePictureURL: senderUserInformation.profilePhotoPath,
      receiverProfilePictureURL: receiverUserInformation.profilePhotoPath,
      lastMessage: lastMessage,
      productPic: productImageURL,
      productName: productName,
      productId: productId,
      timeSent: timeSent,
      sellerId: productOwnerId,
    );

// save to sender
    final senderRef = FirebaseFirestore.instance
        .collection('users')
        .doc(senderUserInformation.userId)
        .collection('chats')
        .doc('${receiverUserInformation.userId}$productId');

    senderRef.get().then((value) {
      if (!value.exists) {
        senderRef.set(
          senderChatContact.toMap(),
        );
      } else {
        senderRef.update({
          'senderName': senderUserInformation.name,
          'receiverName': receiverUserInformation.name,
          'senderProfilePictureURL': senderUserInformation.profilePhotoPath,
          'receiverProfilePictureURL': receiverUserInformation.profilePhotoPath,
          'lastMessage': lastMessage,
          'productPic': productImageURL,
          'productName': productName,
          'timeSent': timeSent.millisecondsSinceEpoch,
        });
      }
    });

    final receiverContactId = const Uuid().v4();
    // Let the sender user know who they are talking to, what product they are talking about, and what the latest message is.
    final receiverChatContact = ChatContact(
      chatContactId: receiverContactId,
      senderName: receiverUserInformation.name,
      receiverName: senderUserInformation.name,
      senderId: receiverUserInformation.userId,
      receiverId: senderUserInformation.userId,
      senderProfilePictureURL: receiverUserInformation.profilePhotoPath,
      receiverProfilePictureURL: senderUserInformation.profilePhotoPath,
      lastMessage: lastMessage,
      productPic: productImageURL,
      productName: productName,
      productId: productId,
      timeSent: timeSent,
      sellerId: productOwnerId,
    );

    // save to receiver
    final receiverRef = FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUserInformation.userId)
        .collection('chats')
        .doc('${senderUserInformation.userId}$productId');

    receiverRef.get().then((value) {
      if (!value.exists) {
        receiverRef.set(
          receiverChatContact.toMap(),
        );
      } else {
        receiverRef.update({
          'senderName': receiverUserInformation.name,
          'receiverName': senderUserInformation.name,
          'senderProfilePictureURL': receiverUserInformation.profilePhotoPath,
          'receiverProfilePictureURL': senderUserInformation.profilePhotoPath,
          'lastMessage': lastMessage,
          'productPic': productImageURL,
          'productName': productName,
          'timeSent': timeSent.millisecondsSinceEpoch,
        });
      }
    });
  }

  @override
  Future<void> saveMessageToMessageSubCollection({
    required String receiverId,
    required String senderId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String productId,
  }) async {
    // The message, we set isSeen as false because when message is sent nobody can see instantly
    final message = Message(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    // we save message to sender
    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc('$receiverId$productId')
        .collection('messages')
        .doc(messageId)
        .set(
          message.toJson(),
        );
    // we save message to receiver

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc('$senderId$productId')
        .collection('messages')
        .doc(messageId)
        .set(
          message.toJson(),
        );
  }

  @override
  Future<void> sendTextMessage({
    required UserInformation senderUserInformation,
    required UserInformation receiverUserInformation,
    required String text,
    required Product product,
  }) async {
    final timeSent = DateTime.now();
    final messageId = const Uuid().v1();

    saveDataToContactsSubCollection(
      senderUserInformation: senderUserInformation,
      receiverUserInformation: receiverUserInformation,
      lastMessage: text,
      productImageURL: product.imagesUrl.first,
      productName: product.title,
      productId: product.productId,
      timeSent: timeSent,
      productOwnerId: product.ownerId,
    );

    saveMessageToMessageSubCollection(
      receiverId: receiverUserInformation.userId,
      senderId: senderUserInformation.userId,
      text: text,
      messageId: messageId,
      productId: product.productId,
      timeSent: timeSent,
    );
  }

  @override
  Stream<Iterable<ChatContact>> getChatContactsToBuy({required String userId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .orderBy('timeSent', descending: true) // new chat contact will appear top
        .snapshots()
        .map((event) => event.docs.map((e) => ChatContact.fromSnapShot(e)).where(
              (element) => element.sellerId != userId,
            ));
  }

  @override
  Stream<Iterable<ChatContact>> getChatContactsToSell({required String userId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .orderBy('timeSent', descending: true) // new chat contact will appear top
        .snapshots()
        .map((event) => event.docs.map((e) => ChatContact.fromSnapShot(e)).where(
              (element) => element.sellerId == userId,
            ));
  }

  Future<void> deleteChatContact({
    required String productId,
    required String senderId,
    required String receiverId,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc('$receiverId$productId')
        .delete();
  }

  @override
  Stream<List<Message>> getChatStream(
      {required String productId, required String senderId, required String receiverId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc('$receiverId$productId')
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Future<void> setChatMessageSeen({
    required String receiverUserId,
    required String senderUserId,
    required String messageId,
    required String productId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUserId)
        .collection('chats')
        .doc('$receiverUserId$productId')
        .collection('messages')
        .doc(messageId)
        .update({'isSeen': true});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc('$senderUserId$productId')
        .collection('messages')
        .doc(messageId)
        .update({'isSeen': true});
  }
}
