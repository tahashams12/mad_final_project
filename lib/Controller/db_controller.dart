import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raabta/Model/user_model.dart';
import 'package:raabta/Model/chat_model.dart';

class DbController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxList<userModel> userList = <userModel>[].obs;
  RxMap<String, chatModel> lastMessages = <String, chatModel>{}.obs;
  RxBool isLoading = false.obs;

  void onInit() {
    super.onInit();
    getUserList();
  }

  // This method gets users with whom the current user has chatted
  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      // Get current user ID
      String currentUserId = auth.currentUser!.uid;

      // Clear existing lists
      userList.clear();
      lastMessages.clear();

      // First, get user's contacts
      var contactsSnapshot = await db
          .collection('users')
          .doc(currentUserId)
          .collection('contacts')
          .get();

      // Create a list of user IDs from contacts
      List<String> contactUserIds = [];

      for (var doc in contactsSnapshot.docs) {
        contactUserIds.add(doc.data()['userId'] as String);
      }

      // For each contact, get their user details
      for (var userId in contactUserIds) {
        var userDoc = await db.collection('users').doc(userId).get();

        if (userDoc.exists && userDoc.data() != null) {
          var user = userModel.fromJson(userDoc.data()!);

          // Get the chat room ID
          String roomId = _getRoomId(currentUserId, userId);

          // Get the last message from the chat
          var lastMessageSnapshot = await db
              .collection('chat')
              .doc(roomId)
              .collection('messages')
              .orderBy('timeStamp', descending: true)
              .limit(1)
              .get();

          if (lastMessageSnapshot.docs.isNotEmpty) {
            // Add the last message to the map
            lastMessages[userId] =
                chatModel.fromJson(lastMessageSnapshot.docs.first.data());

            // Add user to the userList
            userList.add(user);
          } else if (contactUserIds.isNotEmpty) {
            // If no messages but user is in contacts, still add them to the list
            userList.add(user);
          }
        }
      }

      // Sort users by last message timestamp (most recent first)
      userList.sort((a, b) {
        var lastMessageA = lastMessages[a.id];
        var lastMessageB = lastMessages[b.id];

        if (lastMessageA == null && lastMessageB == null) return 0;
        if (lastMessageA == null) return 1;
        if (lastMessageB == null) return -1;

        DateTime timeA =
            DateTime.parse(lastMessageA.timeStamp ?? DateTime.now().toString());
        DateTime timeB =
            DateTime.parse(lastMessageB.timeStamp ?? DateTime.now().toString());

        return timeB.compareTo(timeA); // Most recent first
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to get chat list: $e');
      print("Error getting chat list: $e");
    }
    isLoading.value = false;
  }

  // Helper method to get chat room ID
  String _getRoomId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) > 0) {
      return userId1 + userId2;
    } else {
      return userId2 + userId1;
    }
  }

  // Get the last message for a specific user
  chatModel? getLastMessageForUser(String userId) {
    return lastMessages[userId];
  }
}
