import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter_app/screens/models/user.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  String userId;
  static const String id = "CHAT";

  Chat({Key key, this.userId}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final Firestore _fireStore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _fireStore.collection('messages').add({
        'text': messageController.text,
        'from': widget.userId,
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<QuerySnapshot>(context);

    return SafeArea(
        child: Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                _fireStore.collection('messages').orderBy('date').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );

              List<DocumentSnapshot> docs = snapshot.data.documents;

              List<Widget> messages = docs
                  .map((doc) => Message(
                        from: doc.data['from'],
                        text: doc.data['text'],
                        me: widget.userId == doc.data['from'],
                      ))
                  .toList();

              return ListView(
                controller: scrollController,
                children: <Widget>[
                  ...messages,
                ],
              );
            },
          ),
        ),
         Align(
            alignment: Alignment.bottomCenter,

            child: Padding(

              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 11),
                        hintText: "Enter a Message...",
                        hintStyle: TextStyle(
                          color: Colors.blueAccent,
                        ),
                        border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      ),
                      onSubmitted: (value) => callback(),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: "Send",
                    callback: callback,
                  )
                ],
              ),
            ),
          ),

      ],
    ));
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: IconButton(
        color: Colors.blue,
        onPressed: callback,
        icon: Icon(Icons.send),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from.split('@')[0],
          ),
          Material(
            color: me ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 4.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
              child: Text(
                text,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
