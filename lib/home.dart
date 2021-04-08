import 'package:flutter/material.dart';
import 'package:aquasafe20xx/NewSample.dart';
import 'package:aquasafe20xx/api.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  String pageTitle = "SampleList"; //default page (on launch) is the sample list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewSample()),
                  );
                  index = 1;
                }
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: FloatingActionButton(
                  onPressed: () {
                    // Go to sample creation
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewSample()),
                    );
                  },
                  child: const Icon(Icons.edit),
                  backgroundColor: Colors.blue,
                ),
                selectedIcon: FloatingActionButton(
                  onPressed: () {
                    // Go to sample creation
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewSample()),
                    );
                  },
                  child: const Icon(Icons.edit),
                  backgroundColor: Colors.blue,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                selectedIcon: Icon(Icons.list),
                label: Text('List'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group),
                label: Text('Teams'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
