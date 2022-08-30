import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class ListAllContactPhone extends StatefulWidget {
  const ListAllContactPhone({Key? key}) : super(key: key);

  @override
  State<ListAllContactPhone> createState() => _ListAllContactPhoneState();
}

class _ListAllContactPhoneState extends State<ListAllContactPhone> {
  List<Contact>? contacts;

  String _message = "You are invited";
  final telephony = Telephony.instance;


  @override
  void initState() {

    super.initState();
    getContact();
    initPlatformState();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      setState(() {});
    }
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "***  App Name  ***",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (contacts) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: contacts!.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List? image = contacts![index].photo;
            String num = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
            return ListTile(
                leading: (contacts![index].photo == null)
                    ? const CircleAvatar(child: Icon(Icons.person))
                    : CircleAvatar(backgroundImage: MemoryImage(image!)),
                title: Text(
                    "${contacts![index].name.first} ${contacts![index].name.last}"),
                subtitle: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(num),
                   OutlinedButton(onPressed: ()async{
                     // final _sms = 'sms:$num';
                     //
                     // if(await canLaunch(_sms)){
                     //   await launch(_sms);
                     // }

                     telephony.sendSms(to: num, message: "You are invited.");
                    // await telephony.openDialer(num);

                   }, child: Text("Invite"))
                  ],
                ),
                onTap: () {
                  if (contacts![index].phones.isNotEmpty) {
                    launch('tel: ${num}');
                  }
                });
          },
        ));
  }
}
