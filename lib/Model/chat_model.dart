class chatModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverName;
  String? receiverId;
  String? timeStamp;
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;

  chatModel(
      {this.id,
      this.message,
      this.senderName,
      this.senderId,
      this.receiverName,
      this.receiverId,
      this.timeStamp,
      this.readStatus,
      this.imageUrl,
      this.videoUrl,
      this.audioUrl,
      this.documentUrl});

  chatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    senderName = json['senderName'];
    senderId = json['senderId'];
    receiverName = json['receiverName'];
    receiverId = json['receiverId'];
    timeStamp = json['timeStamp'];
    readStatus = json['readStatus'];
    imageUrl = json['imageUrl'];
    videoUrl = json['videoUrl'];
    audioUrl = json['audioUrl'];
    documentUrl = json['documentUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['senderName'] = this.senderName;
    data['senderId'] = this.senderId;
    data['receiverName'] = this.receiverName;
    data['receiverId'] = this.receiverId;
    data['timeStamp'] = this.timeStamp;
    data['readStatus'] = this.readStatus;
    data['imageUrl'] = this.imageUrl;
    data['videoUrl'] = this.videoUrl;
    data['audioUrl'] = this.audioUrl;
    data['documentUrl'] = this.documentUrl;
    return data;
  }
}
