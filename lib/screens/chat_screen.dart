import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('chats/E0qkSvEHkrDL11BfgKuQ/messages')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            }

            var document = snapshot.data!.docs;
            print("The length is " + snapshot.data!.docs.length.toString());
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(document[index]['text']),
                    ));
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('chats/E0qkSvEHkrDL11BfgKuQ/messages')
                  .add({'text': 'hello'});
            }));
  }
}
