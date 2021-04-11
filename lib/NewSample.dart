import 'package:flutter/material.dart';
import 'package:aquasafe20xx/sample.dart';
import 'package:aquasafe20xx/api.dart' as api;
import 'package:flutter/services.dart';
import 'package:aquasafe20xx/samplelist.dart';

//accessing the sample list
SampleList _samples = new SampleList();

//dropdown iterables
var sColors = [
  "Clear",
  "Cloudy",
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
  //controllers
  final _sampleTitleController = TextEditingController();
  final _samplePhController = TextEditingController();
  final _sampleHardnessController = TextEditingController();

  //pseudo controllers
  String _currentSelectedValueC =
      'Clear'; //Make sure this is never blank at the start of the widget //Colors
  String _currentSelectedValueT =
      'Tap'; //Make sure this is never blank at the start of the widget //Types

  //stepper index
  int _index = 0;

  //snackBars
  final missingField =
      SnackBar(content: Text('Please fill in all form fields!'));
  final extraDecimal = SnackBar(
      content: Text('You cannot have multiple decimals in the pH field!'));

  //Form values
  String title, pH, hardness;

  //checking for empty text fields on submission
  checkNull() {
    if ((title?.isEmpty ?? true) ||
        (pH?.isEmpty ?? true) ||
        (hardness?.isEmpty ?? true)) {
      // detects nulls
      // ( the '?' operator on an object won't run .isEmpty if the instance is null), ?? is a defined-or operator so if it is null it will use 'true'
      return true;
    } else {
      return false;
    }
  }

  //checking for multiple decimals in the ph field
  checkDouble() {
    int count = 0;
    for (int i = 0; i < pH.length; i++) {
      if (i == pH.length - 1) {
        if (pH.substring(i, i + 1) == '.') {
          count++;
        }
      }
      if (pH.substring(i, i + 1) == '.') {
        count++;
      }
    }

    if (count > 1) {
      return false;
    } else {
      return true;
    }
  }

  //converts '_currentSelectedValueT' to an integer value
  convertType() {
    int _type;

    //type
    switch (_currentSelectedValueT.toLowerCase()) {
      case 'unknown':
        {
          _type = 0;
        }
        break;
      case 'tap':
        {
          _type = 1;
        }
        break;
      case 'well':
        {
          _type = 2;
        }
        break;
      case 'river':
        {
          _type = 3;
        }
        break;
      case 'lake':
        {
          _type = 4;
        }
        break;
      case 'rain':
        {
          _type = 5;
        }
        break;
      case 'stream':
        {
          _type = 6;
        }
        break;
      case 'spring':
        {
          _type = 7;
        }
        break;
      case 'hand pump':
        {
          _type = 8;
        }
        break;
    } //switch statement

    return _type;
  }

  //converts '_currentSelectedValueC' to an integer value
  convertColor() {
    int _color;

    //color
    switch (_currentSelectedValueC.toLowerCase()) {
      case 'clear':
        {
          _color = 0;
        }
        break;
      case 'cloudy':
        {
          _color = 1;
        }
        break;
      case 'yellow':
        {
          _color = 2;
        }
        break;
      case 'orange':
        {
          _color = 3;
        }
        break;
      case 'red':
        {
          _color = 4;
        }
        break;
      case 'green-blue':
        {
          _color = 5;
        }
        break;
      case 'black':
        {
          _color = 6;
        }
        break;
      case 'pink':
        {
          _color = 7;
        }
        break;
      case 'green':
        {
          _color = 8;
        }
        break;
    }

    return _color;
  }

  @override
  void initState() {
    super.initState();
    //listeners for controllers (text fields)
    _sampleTitleController.addListener(() {
      title = _sampleTitleController.text;
    }); // title

    _samplePhController.addListener(() {
      pH = _samplePhController.text;
    }); // pH

    _sampleHardnessController.addListener(() {
      hardness = _sampleHardnessController.text;
    }); // hardness
  }

  @override
  void dispose() {
    //when the state is popped, all controllers will get cleaned up and the submitted information will be retrieved
    _sampleTitleController.dispose();
    _samplePhController.dispose();
    _sampleHardnessController.dispose();

    //dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Sample'),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                    "Please enter any data you have collected in the appropriate fields!"),
              ),
              Stepper(
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
                    if (checkNull()) {
                      // don't submit form if empty fields
                      ScaffoldMessenger.of(context).showSnackBar(missingField);
                    } else {
                      if (checkDouble()) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(extraDecimal);
                      }
                    }
                    //converts the field strings into the appropriate types
                    double _pH = double.parse(pH);
                    int _hardness = int.parse(hardness);
                    int _color = convertColor();
                    int _type = convertType();

                    _samples.addSample(
                        Sample(title, _pH, _hardness, _color, _type));

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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Please enter a name for this water sample."),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            TextField(
                              controller: _sampleTitleController,
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Please enter the pH level for this water sample."),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            TextField(
                              controller: _samplePhController,
                              obscureText: false,
                              keyboardType: TextInputType
                                  .number, //number keyboard for this field
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow((RegExp(
                                    r"[.0-9]"))) //prevents pasting any characters besides digits
                              ],
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Please enter the hardness level for this water sample."),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            TextField(
                              controller: _sampleHardnessController,
                              obscureText: false,
                              keyboardType: TextInputType
                                  .number, //number keyboard for this field
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow((RegExp(
                                    r"[0-9]"))) //prevents pasting any characters besides digits
                              ],
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Please select a water color for this water sample."),
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
                          ]),
                    ),
                  ),
                  Step(
                    title: Text("Sample Type:"),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Please select a location type for this water sample."),
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
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        //FORM SUBMISSION EVENT
        onPressed: () {
          // Add your onPressed code here!]
          if (checkNull()) {
            // don't submit form if empty fields
            ScaffoldMessenger.of(context).showSnackBar(missingField);
          } else {
            if (checkDouble()) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(extraDecimal);
            }
          }
          //converts the field strings into the appropriate types
          double _pH = double.parse(pH);
          int _hardness = int.parse(hardness);
          int _color = convertColor();
          int _type = convertType();

          _samples.addSample(Sample(title, _pH, _hardness, _color, _type));
        },
        child: const Icon(Icons.send),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
