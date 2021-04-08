import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  String pageTitle = "SampleList" //default page (on launch) is the sample list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: Appbar(
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
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination( //FAB
                icon: FloatingActionButton(
                        onPressed: () {
                          // Go to sample creation
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => newSample()),
                          );
                        },
                        child: const Icon(Icons.Edit),
                        backgroundColor: Colors.blue,
                      ),
                selectedIcon: Icon(Icons.list),
                label: Text('List'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.List),
                label: Text('List'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.Groups),
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

class newSample extends StatefulWidget {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Stepper(
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
            title: Text("Sample Name:"),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Text("Content for Step 1")),
          ),
          Step(
            title: Text("Sample pH Level:"),
            content: Text("Content for Step 2"),
          ),
        ],
      ),
    );

    floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!]
          Navigator.pop(context);
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
      
    );
  }
}