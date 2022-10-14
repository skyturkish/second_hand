import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/models/message.dart';
import 'package:second_hand/models/chat_contact.dart';
import 'package:second_hand/service/chat/abstract_chat_service.dart';
import 'package:uuid/uuid.dart';

// TODO ya anasını satim gerçekten konuşmaları receiverID-productId diye tutacağım resmen buna itti beni
// TODO kaydederken galiba yine aynı veriyi kaydetmem lazım ? wtf kankam nasıl neden bu nasıl mümkün olabilir mk
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
    required DateTime timeSent,
  }) async {
    // The chatContactId to delete chatcontact
    final chatContactId = const Uuid().v4();
    // Let the sender user know who they are talking to, what product they are talking about, and what the latest message is.
    final chatContact = ChatContact(
      chatContactId: chatContactId,
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
    );
    // The chatContactId to delete chatcontact

    // final receiverChatContactId = const Uuid().v4();

    // // Let the receiver user know who they are talking to, what product they are talking about, and what the latest message is.
    // final receiverChatContact = ChatContact(
    //   chatContactId: receiverChatContactId,
    //   senderName: receiverUserInformation.name,
    //   receiverName: senderUserInformation.name,
    //   senderId: receiverUserInformation.userId,
    //   receiverId: senderUserInformation.userId,
    //   senderProfilePictureURL: receiverUserInformation.profilePhotoPath,
    //   receiverProfilePictureURL: senderUserInformation.profilePhotoPath,
    //   lastMessage: lastMessage,
    //   productPic: productImageURL,
    //   productName: productName,
    //   productId: productId,
    //   timeSent: timeSent,
    // );

    // TODO WHY WE DO THE SAME THING TWICE ??????
    // TODO 2 defa yapmayalım çünkü farklı chatcontact kaydetmiliyiz. bu baya bir şeyi de kolaylaşıtrakcak
    // TODO chat view ekranında da buysa bu buysa bu demesine gerek yok

// save to sender
    final senderRef = FirebaseFirestore.instance
        .collection('users')
        .doc(senderUserInformation.userId)
        .collection('chats')
        .doc('${receiverUserInformation.userId}$productId');

    senderRef.get().then((value) {
      if (!value.exists) {
        senderRef.set(
          chatContact.toMap(),
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

    // save to receiver
    final receiverRef = FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUserInformation.userId)
        .collection('chats')
        .doc('${senderUserInformation.userId}$productId');

    receiverRef.get().then((value) {
      if (!value.exists) {
        receiverRef.set(
          chatContact.toMap(),
        );
      } else {
        receiverRef.update({
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
          message.toMap(),
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
          message.toMap(),
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
      productImageURL: product.imagesPath.first,
      productName: product.title,
      productId: product.productId,
      timeSent: timeSent,
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
    // TODO Burası öncelik
    // Burayı düzelteceksin
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .snapshots()
        .map((event) => event.docs.map((e) => ChatContact.fromSnapShot(e)).where(
              (element) => element.senderId == userId,
            ));

    // return FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userId)
    //     .collection('chats')
    //     .snapshots()
    //     .asyncMap((event) async {
    //   List<ChatContact> contacts = [];
    //   for (var document in event.docs) {
    //     final chatContact = ChatContact.fromMap(document.data());
    //     if (chatContact.senderId == userId) {
    //       contacts.add(chatContact);
    //     }
    //   }
    //   return contacts;
    // });
  }

  @override
  Stream<Iterable<ChatContact>> getChatContactsToSell({required String userId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .snapshots()
        .map((event) => event.docs.map((e) => ChatContact.fromSnapShot(e)).where(
              (element) => element.receiverId == userId,
            ));
    // return FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userId)
    //     .collection('chats')
    //     .snapshots()
    //     .asyncMap((event) async {
    //   List<ChatContact> contacts = [];
    //   for (var document in event.docs) {
    //     final chatContact = ChatContact.fromMap(document.data());
    //     if (chatContact.receiverId == userId) {
    //       contacts.add(chatContact);
    //     }
    //   }
    //   return contacts;
    // });
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
