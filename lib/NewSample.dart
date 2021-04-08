import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;

class NewSample extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<NewSample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Sample'),
      ),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index <= 0) {
            Navigator.pop(context);
          }
          setState(() {
            _index--;
          });
        },
        onStepContinue: () {
          if (_index >= 4) {
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
              child: Column(children: <Widget>[
                Text("Please enter a name for this water sample."),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Title',
                  ),
                  onSubmitted: (String title) async {
                    if (_index < 4) {
                      setState(() {
                        _index++;
                      });
                    }
                  }, // onSubmitted
                ),
              ]),
            ),
          ),
          Step(
            title: Text("Sample pH Level:"),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(children: <Widget>[
                Text("Please enter the pH level for this water sample."),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter pH Level',
                  ),
                  onSubmitted: (String title) async {
                    if (_index < 4) {
                      setState(() {
                        _index++;
                      });
                    }
                  }, // onSubmitted
                ),
              ]),
            ),
          ),
          Step(
            title: Text("Sample Hardness Level:"),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(children: <Widget>[
                Text("Please enter the hardness level for this water sample."),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Hardness Level',
                  ),
                  onSubmitted: (String title) async {
                    if (_index < 4) {
                      setState(() {
                        _index++;
                      });
                    }
                  }, // onSubmitted
                ),
              ]),
            ),
          ),
          Step(
            title: Text("Sample Color:"),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(children: <Widget>[
                Text("Please select a water color for this water sample."),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Color',
                  ),
                  onSubmitted: (String title) async {
                    if (_index < 4) {
                      setState(() {
                        _index++;
                      });
                    }
                  }, // onSubmitted
                ),
              ]),
            ),
          ),
          Step(
            title: Text("Sample Type:"),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(children: <Widget>[
                Text("Please select a location type for this water sample."),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Location Type',
                  ),
                  onSubmitted: (String title) async {
                    if (_index < 4) {
                      setState(() {
                        _index++;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  }, // onSubmitted
                ),
              ]),
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
