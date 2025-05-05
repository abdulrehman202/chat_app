import 'package:chat_app/Model/Message.dart';

import 'User.dart';

class ChatRoom {
  String _id;
  User _sender, _receiver;
  List<Message> _messages = [];

  ChatRoom(this._id, this._sender, this._receiver, this._messages);

  String get id {
    return _id;
  }

  set id(String id) {
    this._id = id;
  }

  User get sender {
    return _sender;
  }

  User get receiver {
    return _receiver;
  }

  List<Message> get messages {
    return _messages;
  }

  set(List<Message> messages) {
    messages.addAll(messages);
  }
}
