import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersimplon/models/image_message.dart';
import 'package:fluttersimplon/models/message.dart';
import 'package:fluttersimplon/models/text_message.dart';
import 'package:fluttersimplon/services/conversations_service.dart';

class MessagesServices {
  ///Retourne les messages d'une conversation
  static CollectionReference<Message> getAll(String conversationId) {
    final collectionRef = FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages');
    return collectionRef.withConverter<Message>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        if (!data.containsKey('text')) {
          return ImageMessage.fromJson(snapshot.data()!);
        }
        return TextMessage.fromJson(snapshot.data()!);
      },
      toFirestore: (message, _) {
        if (message is ImageMessage) {
          return message.toJson();
        }
        return (message as TextMessage).toJson();
      },
    );
  }

  ///Ajoute un message à une conversation
  static Future add(String conversationId, Message message) async {
    //Ajoute le message
    final collectionRef = FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('messages');
    await collectionRef.add(message.toJson());
    //Met à jour la date/heure du dernier message envoyé dans la conversation
    return ConversationsServices.updateLastMessageAt(
      conversationId,
      message.createdAt,
    );
  }
}
