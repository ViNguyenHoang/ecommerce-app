import 'package:ecommerce_app/data/models/message_model.dart';
import 'package:ecommerce_app/logic/cubits/chat_cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatCubit extends Cubit<ChatState> {
  late Socket socket;

  ChatCubit() : super(ChatInitialState()) {
    socket = io(
        "http://localhost:5000",
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();

    socket.on(
        "message-receive",
        (data) => {
              emit(ChatLoadedState(
                  [...state.chats, MessageModel.fromJson(data)]))
            });
  }

  void sendMessage(String text) {
    var messageJson = {"message": text, "sentByMe": socket.id};

    socket.emit("message", messageJson);

    emit(ChatLoadedState([...state.chats, MessageModel.fromJson(messageJson)]));
  }
}
