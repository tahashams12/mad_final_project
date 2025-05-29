import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/chat_controller.dart';
import 'package:raabta/Config/image.dart';
import 'package:raabta/Pages/Chat/Widget/chat.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.only(left: 10),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    chatController.receiverUser.value.profile ??
                        AssetsImage.defaultProfileUrl,
                  ),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatController.receiverUser.value.name ?? "User",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      chatController.receiverUser.value.status ?? "Offline",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              ],
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {},
                tooltip: 'Voice message',
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: false,
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall?.color,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                  onChanged: (value) =>
                      chatController.messageText.value = value,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      chatController
                          .sendMessage(chatController.receiverUser.value.id!);
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () {},
                tooltip: 'Send image',
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  chatController
                      .sendMessage(chatController.receiverUser.value.id!);
                },
                tooltip: 'Send message',
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => ListView.builder(
              reverse: true,
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                final isMe = message.senderId ==
                    chatController
                        .auth.currentUser!.uid; // Format the timestamp
                String formattedTime = "Now";
                if (message.timeStamp != null) {
                  try {
                    DateTime messageTime = DateTime.parse(message.timeStamp!);
                    DateTime now = DateTime.now();

                    if (now.difference(messageTime).inDays == 0) {
                      // Today - show only time
                      formattedTime = DateFormat('hh:mm a').format(messageTime);
                    } else if (now.difference(messageTime).inDays == 1) {
                      // Yesterday
                      formattedTime = "Yesterday, " +
                          DateFormat('hh:mm a').format(messageTime);
                    } else if (now.difference(messageTime).inDays < 7) {
                      // Within a week
                      formattedTime = DateFormat('EEEE, hh:mm a')
                          .format(messageTime); // Day name
                    } else {
                      // Older messages
                      formattedTime =
                          DateFormat('MMM d, hh:mm a').format(messageTime);
                    }
                  } catch (e) {
                    print("Error parsing time: $e");
                  }
                }

                return Chat(
                  sms: message.message ?? "",
                  time: formattedTime,
                  isMe: isMe,
                  status: message.readStatus ?? "sent",
                  imgUrl: message.imageUrl ?? "",
                );
              },
            )),
      ),
    );
  }
}
