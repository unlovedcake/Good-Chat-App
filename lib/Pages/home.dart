

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_chat_app/Theme/color-theme.dart';

import 'chat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{

  int _selectedIndex = 0;

  late AnimationController animationController;
  late List<Widget> _pages;




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _pages = <Widget>[
      Chat(),
      const Icon(
        Icons.settings,
        size: 150,
      ),
      const Icon(
        Icons.person,
        size: 150,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {

    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_selectedIndex == 1 ? "Setting" : "Conversation",),
          automaticallyImplyLeading: false,
              elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add_circle),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

    // bottomNavigationBar: SizeTransition(
    // sizeFactor: animationController,
    // axisAlignment: -1.0,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        backgroundColor: MyTheme.logoColor,
        // iconSize: 40,
        mouseCursor: SystemMouseCursors.grab,

        selectedFontSize: 12,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        //hide label text
        //showSelectedLabels: false,
        //showUnselectedLabels: false,

        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),

        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}


class CallsPage extends StatefulWidget {
  CallsPage({required this.isHideBottomNavBar});
  final Function(bool) isHideBottomNavBar;

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Incoming',
                  ),
                  Tab(
                    text: 'Outgoing',
                  ),
                  Tab(
                    text: 'Missed',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [

            IncomingPage(),
            OutgoingPage(
              isHideBottomNavBar: (value) {

                widget.isHideBottomNavBar(value);
              },
            ),
            Icon(Icons.call_missed_outgoing, size: 350),
          ],
        ),
      ),
    );
  }
}



class IncomingPage extends StatefulWidget {
  @override
  _IncomingPageState createState() => _IncomingPageState();
}

class _IncomingPageState extends State<IncomingPage>
    with AutomaticKeepAliveClientMixin<IncomingPage> {
  int count = 10;

  void clear() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call_received, size: 350),
              Text('Total incoming calls: $count',
                  style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: clear,
          child: Icon(Icons.clear_all),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class OutgoingPage extends StatefulWidget {
  final Function(bool) isHideBottomNavBar;

  OutgoingPage({required this.isHideBottomNavBar});

  @override
  _OutgoingPageState createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage>
    with AutomaticKeepAliveClientMixin<OutgoingPage> {
  final items = List<String>.generate(100, (i) => "Call $i");

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {

      if (notification is UserScrollNotification) {

        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {

          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            print("KEKEKEKE");
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
            print("ssKEKEKEKEadasda");
            break;
          case ScrollDirection.idle:

            break;


        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(

      onNotification: _handleScrollNotification,

      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}'),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}