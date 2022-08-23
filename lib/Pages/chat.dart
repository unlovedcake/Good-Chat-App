import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_chat_app/Pages/search-user.dart';
import 'package:good_chat_app/Router/navigate-route.dart';

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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [

            InkWell(
              onTap: (){
                NavigateRoute.gotoPage(context, SearchUser());
              },
              child: Container(
                height: 50,
                  decoration:   BoxDecoration(
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
                        Spacer(),
                        Text("Search.."),
                        Spacer(),
                        Icon(Icons.search),
                      ],
                    ),
                  )
              ),
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listChat.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return ChatDetail();
                      // }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: listChat[index],
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
