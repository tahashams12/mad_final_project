import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:raabta/Model/chat_model.dart';
import 'package:raabta/Model/user_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  // Message input field
  RxString messageText = ''.obs;

  // Current chat user
  Rx<userModel> receiverUser = userModel().obs;

  // Chat messages
  RxList<chatModel> messages = <chatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Check if we received user from arguments
    if (Get.arguments != null) {
      receiverUser.value = Get.arguments;
      // Start listening to messages
      listenToMessages(receiverUser.value.id!);
    }
  }

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId.compareTo(targetUserId) > 0) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  // Listen to messages in real-time
  void listenToMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);

    db
        .collection('chat')
        .doc(roomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value =
          snapshot.docs.map((doc) => chatModel.fromJson(doc.data())).toList();

      // Mark received messages as read
      _markMessagesAsRead(roomId, targetUserId);
    }, onError: (error) {
      print("Error listening to messages: $error");
    });
  }

  // Mark messages as read
  Future<void> _markMessagesAsRead(String roomId, String senderId) async {
    try {
      // Get all unread messages from the sender
      var unreadMessages = await db
          .collection('chat')
          .doc(roomId)
          .collection('messages')
          .where('senderId', isEqualTo: senderId)
          .where('readStatus', isEqualTo: 'sent')
          .get();

      // Update each message's read status
      for (var doc in unreadMessages.docs) {
        await db
            .collection('chat')
            .doc(roomId)
            .collection('messages')
            .doc(doc.id)
            .update({'readStatus': 'read'});
      }
    } catch (e) {
      print("Error marking messages as read: $e");
    }
  }

  // Send a new message
  Future<void> sendMessage(String targetUserId) async {
    if (messageText.value.trim().isEmpty) return;

    isLoading.value = true;

    try {
      String roomId = getRoomId(targetUserId);
      String messageId = Uuid().v4();

      // Get current user details
      var currentUser = auth.currentUser;
      var userDoc = await db.collection('users').doc(currentUser!.uid).get();
      var userData = userModel.fromJson(userDoc.data() ?? {});

      // Create message
      final newMessage = chatModel(
        id: messageId,
        message: messageText.value.trim(),
        senderId: currentUser.uid,
        senderName: userData.name,
        receiverId: targetUserId,
        receiverName: receiverUser.value.name,
        timeStamp: DateTime.now().toString(),
        readStatus: 'sent',
      );

      // Save to Firestore
      await db
          .collection('chat')
          .doc(roomId)
          .collection('messages')
          .doc(messageId)
          .set(newMessage.toJson());

      // Clear input field
      messageText.value = '';
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
      print("Error sending message: $e");
    }

    isLoading.value = false;
  }
}
