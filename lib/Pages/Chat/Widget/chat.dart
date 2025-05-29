import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:raabta/Config/image.dart";

class Chat extends StatelessWidget {
  final String sms;
  final String time;
  final bool isMe;
  final String status;
  final String imgUrl;
  const Chat({
    required this.sms,
    required this.time,
    required this.isMe,
    required this.status,
    required this.imgUrl,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              child: Icon(Icons.person, size: 16, color: Theme.of(context).colorScheme.primary),
            ),
          SizedBox(width: !isMe ? 8.0 : 0),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 16 : 0),
                      topRight: Radius.circular(isMe ? 0 : 16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: isMe 
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                        : Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: imgUrl == ""
                      ? Text(
                          sms,
                          style: TextStyle(
                            color: isMe ? Colors.white : null,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imgUrl,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 100,
                                    width: double.infinity,
                                    color: Colors.grey.withOpacity(0.3),
                                    child: Icon(Icons.error_outline),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              sms,
                              style: TextStyle(
                                color: isMe ? Colors.white : null,
                              ),
                            )
                          ],
                        ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelSmall?.color,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(width: 4),
                    if (!isMe) 
                      SvgPicture.asset(
                        AssetsImage.boyPic,
                        width: 14,
                      ),
                    if (isMe)
                      Icon(
                        status == "read" ? Icons.done_all : Icons.done,
                        size: 14,
                        color: status == "read" 
                            ? Theme.of(context).colorScheme.primary 
                            : Theme.of(context).textTheme.labelSmall?.color,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
