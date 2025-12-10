import 'package:demo/core/common/custom_app_bar.dart';
import 'package:demo/extensions/app_extensions.dart';
import 'package:demo/features/chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  /// Controllers
  final msgCtr = TextEditingController();

  /// Variables
  var isMyMsg = false;

  /// Lists
  var msgList = <MessageModel>[];

  Stream<List<MessageModel>> chatStream() async* {
    yield msgList;
  }

  void _sendMessage() {
    if (msgCtr.text.trim().isEmpty) return;

    final message = MessageModel(
      msg: msgCtr.text.trim(),
      createdAt: DateTime.now().toString(),
      isMyMessage: isMyMsg,
    );

    setState(() {
      isMyMsg = !isMyMsg;
      msgList.insert(0, message); // insert at top (reversed list)
    });

    msgCtr.clear();
  }

  /// Format the message date label
  static String getMessageDateLabel(String messageDateStr) {
    // Parse the string to DateTime object
    DateTime messageDate = DateTime.parse(messageDateStr);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day); // Midnight today
    DateTime startOfWeek = today.subtract(
      Duration(days: today.weekday - 1),
    ); // Monday of this week

    // Get the time difference from now
    final difference = now.difference(messageDate);

    // If the message is sent today (same date, any time of the day)
    if (messageDate.isAfter(today) && messageDate.isBefore(now)) {
      return 'Today';
    }
    // If the message was sent yesterday
    else if (difference.inDays == 1 && messageDate.isBefore(today)) {
      return 'Yesterday';
    }

    // If the message is within this week (Monday to Now), show only the day name
    if (messageDate.isAfter(startOfWeek) && messageDate.isBefore(now)) {
      return DateFormat(
        'EEEE',
      ).format(messageDate); // Only the day name (e.g., "Monday")
    }

    // If the message is within the current year, show the day with the date (e.g., "Monday, 22 May")
    if (messageDate.year == now.year) {
      return DateFormat('EEEE, d MMM').format(messageDate);
    }

    // For all older messages, show full date with year (e.g., "Monday, 22 May 2023")
    return DateFormat('EEEE, d MMM yyyy').format(messageDate);
  }

  /// Method to format message time.
  String formatMessageTime(DateTime messageTime) {
    final now = DateTime.now();
    final difference = now.difference(messageTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else {
      // Format time in hh:mm AM/PM
      final formatter = DateFormat('h:mm a'); // 12-hour format
      return formatter.format(messageTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: custommAppBar(title: "ChatView"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<List<MessageModel>>(
                stream: chatStream(),
                builder: (context, snapshot) {
                  final msgList = snapshot.data ?? [];
                  return msgList.isEmpty
                      ? Expanded(
                        child: Center(child: Text("Start Conversation")),
                      )
                      : Flexible(
                        child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: msgList.length,
                          itemBuilder: (context, index) {
                            final msg = msgList[index];
                            String currentDateLabel = getMessageDateLabel(
                              msg.createdAt,
                            );
                            bool showDateLabel = false;
                            if (index == msgList.length - 1 ||
                                getMessageDateLabel(
                                      msgList[index + 1].createdAt,
                                    ) !=
                                    currentDateLabel) {
                              showDateLabel = true;
                            }
                            return Align(
                              alignment:
                                  msg.isMyMessage
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: index == msgList.length - 1 ? 0 : 10,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      msg.isMyMessage
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    if (showDateLabel) ...{
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(currentDateLabel),
                                        ),
                                      ),
                                    },
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.blue,

                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        msg.msg,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      formatMessageTime(
                                        DateTime.parse(msg.createdAt),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                },
              ),
              2.h,
              _chatInputField(context),
              5.h,
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatInputField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: msgCtr,
            decoration: InputDecoration(
              hintText: "Type a message...",
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        10.w,
        GestureDetector(
          onTap: () {
            _sendMessage();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
