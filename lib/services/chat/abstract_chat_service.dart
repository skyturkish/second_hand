import 'package:second_hand/models/chat_contact.dart';
import 'package:second_hand/models/message.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user_information.dart';

abstract class IChatCloudFireStoreService {
  // get Chat Contacts who I did write to buy their items
  Stream<Iterable<ChatContact>> getChatContactsToBuy({required String userId});
  // get Chat Conctacts who users did write to me to buy my items
  Stream<Iterable<ChatContact>> getChatContactsToSell({required String userId});
  // we take both id, because maybe the admin role will be exist in the future ?
  // The admin should be able to see the messages
  Stream<List<Message>> getChatStream({
    required String senderId,
    required String receiverId,
    required String productId,
  });
  // Let the user know who they are talking to, what product they are talking about, and what the latest message is.
  Future<void> saveDataToContactsSubCollection({
    required UserInformation senderUserInformation,
    required UserInformation receiverUserInformation,
    required String lastMessage,
    required String productImageURL,
    required String productName,
    required DateTime timeSent,
    required String productId,
    required String productOwnerId,
  });
  // save message to firebase,
  Future<void> saveMessageToMessageSubCollection({
    required String receiverId,
    required String senderId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String productId,
  });

  // we will use all function inside this function
  Future<void> sendTextMessage({
    required UserInformation senderUserInformation,
    required UserInformation receiverUserInformation,
    required String text,
    required Product product,
  });
  // set message as seen
  Future<void> setChatMessageSeen({
    required String receiverUserId,
    required String senderUserId,
    required String messageId,
    required String productId,
  });
}
