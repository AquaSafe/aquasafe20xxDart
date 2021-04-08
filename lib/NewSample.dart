import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;

var sColors = [
  "Clear",
  "Yellow",
  "Orange",
  "Red",
  "Green-blue",
  "Black",
  "Pink",
  "Green"
];

var sTypes = [
  "Tap",
  "Well",
  "River",
  "Lake",
  "Rain",
  "Stream",
  "Spring",
  "Hand pump"
];

class NewSample extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<NewSample> {
  String _currentSelectedValueC =
      'Clear'; //Make sure this is never blank at the start of the widget //Colors
  String _currentSelectedValueT =
      'Tap'; //Make sure this is never blank at the start of the widget //Types
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
            return;
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
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        hintText: 'Select Color',
                        border: OutlineInputBorder(),
                      ),
                      isEmpty: _currentSelectedValueC == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValueC,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValueC = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: sColors.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                // TextField(
                //   obscureText: false,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Select Color',
                //   ),
                //   onSubmitted: (String title) async {
                //     if (_index < 4) {
                //       setState(() {
                //         _index++;
                //       });
                //     }
                //   }, // onSubmitted
                // ),
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
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        hintText: 'Select Location Type',
                        border: OutlineInputBorder(),
                      ),
                      isEmpty: _currentSelectedValueT == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValueT,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValueT = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: sTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
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
