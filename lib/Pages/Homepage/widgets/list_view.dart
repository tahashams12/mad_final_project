import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raabta/Controller/db_controller.dart';
import 'package:raabta/Pages/Homepage/widgets/chat_tile.dart';
import 'package:raabta/Config/image.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.put(DbController());
    return Obx(() {
      if (dbController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (dbController.userList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              SizedBox(height: 16),
              Text(
                "No chats yet",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                "Tap the + button to start a conversation",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        itemCount: dbController.userList.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final user = dbController.userList[index];
          final lastMessage = dbController.getLastMessageForUser(user.id!);

          // Format the last message
          String messageText = user.bio ?? "No messages yet";
          String timeText = "";

          if (lastMessage != null) {
            // Show the message text
            messageText = lastMessage.message ?? "No text";

            // Format time
            try {
              final DateTime messageTime =
                  DateTime.parse(lastMessage.timeStamp!);
              final DateTime now = DateTime.now();

              if (now.difference(messageTime).inDays == 0) {
                // Today - show time only
                final hour = messageTime.hour > 12
                    ? messageTime.hour - 12
                    : messageTime.hour;
                final period = messageTime.hour >= 12 ? 'PM' : 'AM';
                timeText =
                    '$hour:${messageTime.minute.toString().padLeft(2, '0')} $period';
              } else if (now.difference(messageTime).inDays == 1) {
                // Yesterday
                timeText = 'Yesterday';
              } else if (now.difference(messageTime).inDays < 7) {
                // Show day name
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                timeText = days[messageTime.weekday - 1];
              } else {
                // Show date
                timeText = '${messageTime.day}/${messageTime.month}';
              }
            } catch (e) {
              print("Error formatting time: $e");
            }
          }

          return InkWell(
            onTap: () {
              Get.toNamed('/chat', arguments: user);
            },
            child: ChatTile(
              imageUrl: user.profile ?? AssetsImage.defaultProfileUrl,
              name: user.name ?? 'Unknown',
              message: messageText,
              time: timeText,
            ),
          );
        },
      );
    });
  }
}
