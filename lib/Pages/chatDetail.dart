import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:good_chat_app/Models/user-model.dart';
import 'package:good_chat_app/chat-provider.dart';

import '../firestore-constant.dart';

class ChatDetail extends StatefulWidget {

  final UserModel user;
  const ChatDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {

  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent:
            "Hey Kriss, I am doing fine dude. wbu? adadasd adadasd adads ada",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  List<QueryDocumentSnapshot> listMessage = [];

  User? user = FirebaseAuth.instance.currentUser;

  String? currentUserId;
  String? groupChatId;
  String? peerId = "";


  void read(){
    currentUserId = user!.uid;

    if (currentUserId!.compareTo(peerId!) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }

    updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId!,
      {FirestoreConstants.chattingWith: peerId},
    );
  }

  @override
  void initState() {

    super.initState();

    read();
  }


  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {


      var documentReference =  FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId!)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': currentUserId,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'message': content,
            'type': type
          },
        );
      }).whenComplete(() {
        Fluttertoast.showToast(msg: 'Sent');
      });

    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  // void onSendMessage(String content, int type) {
  //   if (content.trim().isNotEmpty) {
  //     messageController.clear();
  //
  //     ChatProvider.sendMessage(content, type, groupChatId!, currentUserId!, peerId!);
  //
  //   } else {
  //     Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
  //   }
  // }

  Future<void> updateDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    return  FirebaseFirestore.instance.collection(collectionPath).doc(docPath).update(dataNeedUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      widget.user.imageUrl.toString()),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${widget.user.firstName}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // ListView.builder(
          //   itemCount: messages.length,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding:
          //           EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          //       child: Align(
          //         alignment: (messages[index].messageType == "receiver"
          //             ? Alignment.topLeft
          //             : Alignment.topRight),
          //         child: Wrap(
          //           children: [
          //         (messages[index].messageType == "receiver" ?  CircleAvatar(
          //                 child: Icon(
          //               Icons.person,
          //               size: 20,
          //             ),radius: 10,) : SizedBox() ),
          //             Column(
          //               children: [
          //                 Container(
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(20),
          //                     color: (messages[index].messageType == "receiver"
          //                         ? Colors.grey.shade200
          //                         : Colors.blue[200]),
          //                   ),
          //                   padding: EdgeInsets.all(16),
          //                   child: Text(
          //                     messages[index].messageContent,
          //                     style: TextStyle(fontSize: 15),
          //                   ),
          //                 ),
          //                 Text(" 3 minutes ago",style: TextStyle(fontSize: 10,color: Colors.grey),),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          buildListMessage(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4,
                      onChanged: (value) => {setState(() =>  value)},
                      decoration: InputDecoration(
                          hintText: "   Write Comment",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.all(10),


                       ),
                    ),
                  ),
                  // Expanded(
                  //   child: TextFormField(
                  //     autofocus: true,
                  //     autocorrect: false,
                  //     keyboardType: TextInputType.multiline,
                  //     minLines: 1,
                  //     maxLines: 4,
                  //     decoration: InputDecoration(
                  //         hintText: "Write message...",
                  //         hintStyle: TextStyle(color: Colors.black54),
                  //         border: InputBorder.none),
                  //   ),
                  // ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      onSendMessage(messageController.text, 0);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),


    );


  }
  Widget buildListMessage() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId!)
          .orderBy(FirestoreConstants.timestamp, descending: true)
          .limit(5)
          .snapshots(),
      //stream: ChatProvider.getChatStream(groupChatId!, 10),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          listMessage = snapshot.data!.docs;
          if (listMessage.length > 0) {
            return Container(
              height: 300,
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Text(groupChatId!.toString()),
                      Text(snapshot.data!.docs[index]['message']),
                    ],
                  );
                },
                itemCount: snapshot.data?.docs.length,
                reverse: true,

              ),
            );
          } else {
            return Center(child: Text("No message here yet..."));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(

            ),
          );
        }
      },
    );
  }


  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUserId) {
        return Row(children: [

          messageChat.type == TypeMessage.text ?
          Container(
            child: Text(
              document.get("message"),
              style: TextStyle(color: Colors.blue),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            width: 200,
            decoration: BoxDecoration( borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only( right: 10),
          ) : Text(""),

        ],);
      }

     return Text("No Data");
    } else {
      return SizedBox.shrink();
    }
  }

}


class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  ChatPageArguments({required this.peerId, required this.peerAvatar, required this.peerNickname});
}
