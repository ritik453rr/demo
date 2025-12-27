import 'package:demo/core/common/custom_app_bar.dart';
import 'package:demo/extensions/app_extensions.dart';
import 'package:demo/features/messages/model/message_model.dart';
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
  var scrollCtr = ScrollController();

  /// Lists
  var msgList = <MessageModel>[];

  Stream<List<MessageModel>> chatStream() async* {
    yield msgList;
  }

  void sendMessage() {
    if (msgCtr.text.trim().isEmpty) return;

    final message = MessageModel(
      msg: msgCtr.text.trim(),
      createdAt: DateTime.now().toString(),
      isMyMessage: isMyMsg,
    );

    setState(() {
      isMyMsg = !isMyMsg;
      msgList.add(message);
    });

    msgCtr.clear();
    scrollToBottom();
  }

  void scrollToBottom({int time = 10}) {
    if (!scrollCtr.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scrollCtr.jumpTo(
      //   scrollCtr.position.maxScrollExtent,
      //   // duration: const Duration(milliseconds: 300),
      //   // curve: Curves.easeOut,
      // );
      scrollCtr.animateTo(
        scrollCtr.position.maxScrollExtent,
        duration: Duration(milliseconds: time),
        curve: Curves.easeOut,
      );
    });
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

  final focusNode = FocusNode();

  // @override
  // void initState() {
  //   super.initState();
  //   focusNode.addListener(() {
  //     if (focusNode.hasFocus&& scrollCtr.hasClients) {
  //       // 1. Define a threshold (e.g., 100 pixels from the bottom)
  //       // extentAfter is the distance from the current bottom of the viewport
  //       // to the total end of the list.
  //       double threshold = 100.0;
  //       bool isNearBottom = scrollCtr.position.extentAfter < threshold;

  //       if (isNearBottom) {
  //         scrollToBottom();
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This detects if the keyboard is open
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // 2. If keyboard is opening, trigger a scroll to the NEW bottom
    if (isKeyboardVisible && scrollCtr.hasClients) {
      // We check if the user is already at or near the bottom
      // before the keyboard finishes pushing the UI up.
      if (scrollCtr.position.extentAfter < 200) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // if (scrollCtr.hasClients) {
          // Jump to maxScrollExtent. The +40 ensures it clears any
          // extra padding you might have at the bottom.
          scrollCtr.jumpTo(scrollCtr.position.maxScrollExtent);
          // }
        });
      }
    }
    return Scaffold(
      appBar: custommAppBar(title: "ChatView"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder<List<MessageModel>>(
                stream: chatStream(),
                builder: (context, snapshot) {
                  final msgList = snapshot.data ?? [];
                  return msgList.isEmpty
                      ? Expanded(
                        child: Center(child: Text("Start Conversation")),
                      )
                      : Expanded(
                        child: ListView.builder(
                          controller: scrollCtr,

                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: msgList.length,
                          itemBuilder: (context, index) {
                            final msg = msgList[index];
                            String currentDateLabel = getMessageDateLabel(
                              msg.createdAt,
                            );
                            bool showDateLabel = false;
                            if (index == 0 ||
                                getMessageDateLabel(msgList[index].createdAt) !=
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
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                            0.65,
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
              // Flexible(child: SizedBox(
              //   height: 10,
              // )),
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
            focusNode: focusNode,
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
            sendMessage();
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
