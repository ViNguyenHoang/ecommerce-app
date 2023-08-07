import 'package:ecommerce_app/data/models/message_model.dart';
import 'package:ecommerce_app/logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:ecommerce_app/logic/cubits/chat_cubit/chat_state.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String routeName = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat với shop")),
      backgroundColor: Colors.black,
      body: SafeArea(child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    final currentMessage = state.chats[index];

                    return MessageItem(
                      sentByMe: currentMessage.sentByme ==
                          BlocProvider.of<ChatCubit>(context).socket.id,
                      message: currentMessage,
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: msgInputController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              BlocProvider.of<ChatCubit>(context)
                                  .sendMessage(msgInputController.text);

                              msgInputController.text = "";
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ))),
                  ),
                ),
              )
            ],
          );
        },
      )),
    );
  }
}

class MessageItem extends StatelessWidget {
  final bool sentByMe;
  final MessageModel message;
  const MessageItem({super.key, required this.sentByMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: sentByMe ? Colors.purple : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                message.message!,
                style: TextStyle(
                    color: sentByMe ? Colors.white : Colors.purple,
                    fontSize: 18),
              ),
              const GapWidget(),
              Text(
                "1:10am",
                style: TextStyle(
                    color: (sentByMe ? Colors.white : Colors.purple)
                        .withOpacity(0.6),
                    fontSize: 10),
              )
            ],
          )),
    );
  }
}
