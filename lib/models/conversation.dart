import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  Conversation({
    required this.id,
    required this.from,
    required this.to,
    required this.createdAt,
  });
  Conversation.fromJson(String id, Map<String, Object?> json)
      : this(
          id: id,
          from: json['from'].toString(),
          to: json['to'].toString(),
          createdAt: json['createdAt'] as Timestamp,
        );

  final String id;
  final String from;
  final String to;
  final Timestamp createdAt;

  Map<String, Object?> toJson() {
    return {
      'from': from,
      'to': to,
      'createdAt': createdAt,
    };
  }
}
