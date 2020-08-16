import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_app/screens/chat_screen.dart';
import 'package:flutter_firebase_chat_app/screens/prayers_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
	List<Map<String, Object>> _pages;
	int _selectedPageIndex = 0;

	@override
	void initState() {
		super.initState();
		_pages = [
			{'page': PrayersScreen(), 'title': 'Prayers'},
			{'page': ChatScreen(), 'title': 'Chat'}
		];
	}

	void _selectPage(int index) {
		setState(() {
			_selectedPageIndex = index;
		});
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    title: Text('FlutterChat'),
		    actions: <Widget>[
			    DropdownButton(
				    underline: Container(),
				    icon: Icon(
					    Icons.more_vert,
					    color: Theme.of(context).primaryIconTheme.color,
				    ),
				    items: [
					    DropdownMenuItem(
						    child: Container(
							    child: Row(
								    children: <Widget>[
									    Icon(Icons.exit_to_app),
									    SizedBox(width: 8),
									    Text('Logout'),
								    ],
							    ),
						    ),
						    value: 'logout',
					    ),
				    ],
				    onChanged: (itemIdentifier) {
					    if (itemIdentifier == 'logout') {
						    FirebaseAuth.instance.signOut();
					    }
				    },
			    ),
		    ],
	    ),
	    body: _pages[_selectedPageIndex]['page'],
	    bottomNavigationBar: BottomNavigationBar(
		    onTap: _selectPage,
		    backgroundColor: Theme.of(context).primaryColor,
		    unselectedItemColor: Colors.white,
		    selectedItemColor: Theme.of(context).accentColor,
		    currentIndex: _selectedPageIndex,
		    items: [
			    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('Prayer')),
			    BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Chat')),
		    ],
	    ),
    );
  }
}
