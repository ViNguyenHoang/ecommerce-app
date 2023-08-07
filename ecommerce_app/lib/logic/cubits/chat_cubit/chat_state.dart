import 'package:ecommerce_app/data/models/message_model.dart';

abstract class ChatState {
  final List<MessageModel> chats;
  ChatState(this.chats);
}

class ChatInitialState extends ChatState {
  ChatInitialState() : super([]);
}

class ChatLoadedState extends ChatState {
  ChatLoadedState(super.chats);
}

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState(this.message, super.chats);
}
