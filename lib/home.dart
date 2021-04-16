import 'dart:io';

import 'package:aquasafe20xx/sample.dart';
import 'package:flutter/material.dart';
import 'package:aquasafe20xx/NewSample.dart';
import 'package:aquasafe20xx/analysis.dart';
import 'package:aquasafe20xx/samplelist.dart';
import 'package:aquasafe20xx/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

//sampleList init
SampleList _samples = new SampleList();

int _globalIndex = 1;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Auto refresh sample list when home comes into view
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> samples =
          await api.API.listSamples(prefs.getString("token"));

      _samples.loadList(samples['samples']);
    });
  }

  int _selectedIndex = 1;
  String pageTitle =
      "Water Samples"; //default page (on launch) is the sample list

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
            onDestinationSelected: (int index) async {
              if (index == 0) {
                int value = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewSample()),
                );
                index = 1;
              }
              setState(() {
                // if (index == _selectedIndex) {
                //   ContentSpace(_selectedIndex);
                // }
                if (index == 2) {
                  pageTitle = "Teams";
                } else {
                  pageTitle = "Water Samples";
                }
                _selectedIndex = index;
                _globalIndex = _selectedIndex;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: FloatingActionButton(
                  onPressed: () async {
                    int value = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewSample()),
                    );
                    setState(() {
                      _selectedIndex = _selectedIndex;
                    });
                  },
                  child: const Icon(Icons.edit),
                  backgroundColor: Colors.blue,
                ),
                selectedIcon: FloatingActionButton(
                  onPressed: () async {
                    int value = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewSample()),
                    );
                    setState(() {
                      print(value);
                      _selectedIndex = _selectedIndex;
                      print(_selectedIndex);
                    });
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
          ContentSpace()
        ],
      ),
    );
  }
}

class ContentSpace extends StatefulWidget {
  @override
  _ContentSpace createState() => _ContentSpace();
}

class _ContentSpace extends State<ContentSpace> {
  findType(index) {
    String type;
    switch (_samples.retrieveList()[index].location) {
      case 0:
        {
          type = 'Unknown';
        }
        break;
      case 1:
        {
          type = 'Tap';
        }
        break;
      case 2:
        {
          type = 'Well';
        }
        break;
      case 3:
        {
          type = 'River';
        }
        break;
      case 4:
        {
          type = 'Lake';
        }
        break;
      case 5:
        {
          type = 'Rain';
        }
        break;
      case 6:
        {
          type = 'Stream';
        }
        break;
      case 7:
        {
          type = 'Spring';
        }
        break;
      case 8:
        {
          type = 'Hand pump';
        }
        break;
    } //switch statement

    return type;
  }

  findColor(index) {
    String color;
    switch (_samples.retrieveList()[index].color) {
      case 0:
        {
          color = 'Clear';
        }
        break;
      case 1:
        {
          color = 'Cloudy';
        }
        break;
      case 2:
        {
          color = 'Yellow';
        }
        break;
      case 3:
        {
          color = 'Orange';
        }
        break;
      case 4:
        {
          color = 'Red';
        }
        break;
      case 5:
        {
          color = 'Green-blue';
        }
        break;
      case 6:
        {
          color = 'Black';
        }
        break;
      case 7:
        {
          color = 'Pink';
        }
        break;
      case 8:
        {
          color = 'Green';
        }
        break;
    } //switch statement

    return color;
  }

  //bools
  bool remove = false;

  removeSet(bool which) {
    remove = which;
  }

  //dialog
  @override
  Widget build(BuildContext context) {
    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Sample'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You are about to delete a sample.'),
                  Text('Would you like to proceed?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  removeSet(true);
                  print(remove);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  removeSet(false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    //will change based on whichever index is selected
    int currentIndex = _globalIndex;
    switch (currentIndex) {
      case 1:
        {
          return Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: _samples.retrieveList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Column(children: <Widget>[
                      InkWell(
                          splashColor: Colors.blue,
                          onLongPress: () async {
                            await _showDialog();
                            if (remove) {
                              setState(() {
                                _samples
                                    .retrieveList()
                                    .remove(_samples.retrieveList()[index]);
                                print(_samples.retrieveList());
                              });
                            } else {}
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnalysisPage(index)),
                            );
                          },
                          child: ListTile(
                              leading: Icon(Icons.fact_check),
                              title: Text(_samples.retrieveList()[index].name),
                              subtitle: Text("Color: " +
                                  findColor(index) +
                                  "; Type: " +
                                  findType(index))))
                    ]));
                  }));
        }
        break;
      case 2:
        {
          return Expanded(child: Text("Nothing to see here"));
        }
        break;
    } //switch
  }
}
