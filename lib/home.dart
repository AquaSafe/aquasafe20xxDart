import 'package:flutter/material.dart';
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
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                //FAB
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
                icon: Icon(Icons.list_outlined),
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

class NewSample extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<NewSample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index <= 0) {
            return;
          }
          setState(() {
            _index--;
          });
        },
        onStepContinue: () {
          if (_index >= 1) {
            return;
          }
          setState(() {
            _index++;
          });
        },
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        steps: [
          Step(
            title: Text("Sample Title:"),
            content: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Title',
                ),
              ),
            ),
          ),
          Step(
            title: Text("Sample pH Level:"),
            content: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter pH Level',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!]
          Navigator.pop(context);
        },
        child: const Icon(Icons.send),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
