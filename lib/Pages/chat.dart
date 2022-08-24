import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_chat_app/Models/user-model.dart';
import 'package:good_chat_app/Pages/search-user.dart';
import 'package:good_chat_app/Router/navigate-route.dart';

import '../chat-user.dart';
import 'chatDetail.dart';
import 'conversation-list.dart';
import 'home.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Widget> listChat = [
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Jhon Wick"),
            Text(" Good To Know"),
          ],
        ),
        Spacer(),
        Text(" Today"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Mike Wick"),
            Text(" Hello"),
          ],
        ),
        Spacer(),
        Text(" Yesterday"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Jhon Cake"),
            Text(" How are you?"),
          ],
        ),
        Spacer(),
        Text(" Today"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Rhea Pre"),
            Text(" Nice to meet you."),
          ],
        ),
        Spacer(),
        Text(" Now"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Jhon Wick"),
            Text(" Good To Know"),
          ],
        ),
        Spacer(),
        Text(" Today"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Mike Wick"),
            Text(" Hello"),
          ],
        ),
        Spacer(),
        Text(" Yesterday"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Jhon Cake"),
            Text(" How are you?"),
          ],
        ),
        Spacer(),
        Text(" Today"),
      ],
    ),
    Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),
        Column(
          children: [
            Text(" Rhea Pre"),
            Text(" Nice to meet you."),
          ],
        ),
        Spacer(),
        Text(" Now"),
      ],
    ),
  ];

  Stream<QuerySnapshot> getFirestoreData() {
    return FirebaseFirestore.instance.collection('table-user').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                NavigateRoute.gotoPage(context, SearchUser());
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    // borderRadius:  BorderRadius.only(
                    //   topLeft: Radius.circular(40.0),
                    //   topRight: Radius.circular(40.0),
                    // )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(user!.photoURL.toString())),
                        Spacer(),
                        Text("Search.."),
                        Spacer(),
                        Icon(Icons.search),
                      ],
                    ),
                  )),
            ),
            // TextFormField(
            //   readOnly: true,
            //   decoration: InputDecoration(
            //     hintText: "Search...",
            //     hintStyle: TextStyle(color: Colors.grey.shade600),
            //     prefixIcon: Icon(
            //       Icons.search,
            //       color: Colors.grey.shade600,
            //       size: 20,
            //     ),
            //     filled: true,
            //     fillColor: Colors.grey.shade100,
            //     contentPadding: EdgeInsets.all(8),
            //     enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20),
            //         borderSide: BorderSide(color: Colors.grey.shade100)),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getFirestoreData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data?.docs.length ?? 0) > 0) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data?.docs[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
                    } else {
                      return const Center(
                        child: Text('No user found...'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            // StreamBuilder<QuerySnapshot>(
            //     stream: FirebaseFirestore.instance
            //         .collection('table-conversation')
            //         //
            //         // .doc(user!.uid.toString())
            //         // .collection(user.uid.toString())
            //         // .orderBy("dateCreated", descending: true)
            //         // .limit(5)
            //         .snapshots(),
            //     builder: (context,  snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //
            //       }
            //
            //       else if (snapshot.data!.docs.isEmpty) {
            //         return const Center(child: Text("No Chat Yet..."));
            //       } else {
            //         return Expanded(
            //           child: ListView.builder(
            //               itemCount: snapshot.data?.docs.length,
            //               itemBuilder: (context, index) {
            //
            //                 final DocumentSnapshot personWhoChat =
            //                 snapshot.data!.docs[index];
            //
            //                 return  Row(
            //                   children: [
            //                     const CircleAvatar(
            //                       radius: 30,
            //                       child: Icon(
            //                         Icons.person,
            //                         size: 50,
            //                       ),
            //                     ),
            //                     Column(
            //                       children:  [
            //                         Text(personWhoChat.get('message')),
            //                         // Text(personWhoChat.get("user")['reciverName']),
            //                         //Text(personWhoChat[index]['idFrom']),
            //                       ],
            //                     ),
            //                     Spacer(),
            //                     Text(" Today"),
            //                   ],
            //                 );
            //               }),
            //         );
            //       }
            //     })
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
    final firebaseAuth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);

      if (userChat.id == user!.uid) {
        return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetail(
                          user: UserModel.fromMap(documentSnapshot),
                        )));
          },
          child: ListTile(
            leading: documentSnapshot.get('imageUrl').isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      documentSnapshot.get('imageUrl'),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                                color: Colors.grey,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null),
                          );
                        }
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return const Icon(Icons.account_circle, size: 50);
                      },
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
            title: Column(
              children: [
                Text(
                  documentSnapshot.get('firstName'),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
