import 'package:flutter/material.dart';
import 'package:aquasafe20xx/samplelist.dart';
import 'package:aquasafe20xx/sample.dart';

//get the users sample list
SampleList userInfo = new SampleList();

int _sample = 0;

class AnalysisPage extends StatefulWidget {
  final int index;
  const AnalysisPage(this.index);

  _AnalysisPage createState() => _AnalysisPage(/*index*/);
}

class _AnalysisPage extends State<AnalysisPage> {
  int index = 0;
  String pHAnalysis;
  String hardnessAnalysis;
  String cAnalysis;
  //_AnalysisPage(this.index);

  findType(index) {
    String type;
    switch (index) {
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
    switch (index) {
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

  colorId(color) {
    switch (color) {
      case 0:
        {
          return Colors.white;
        }
        break;
      case 1:
        {
          return Colors.grey;
        }
        break;
      case 2:
        {
          return Colors.yellow;
        }
        break;
      case 3:
        {
          return Colors.orange;
        }
        break;
      case 4:
        {
          return Colors.red;
        }
        break;
      case 5:
        {
          return Colors.teal;
        }
        break;
      case 6:
        {
          return Colors.black;
        }
        break;
      case 7:
        {
          return Colors.pink;
        }
        break;
      case 8:
        {
          return Colors.green;
        }
        break;
    } //switch statement
  }

  colorAnalysis(index) {
    switch (index) {
      case 0:
        {
          return " that there are no apparent contaminant in the water. Clear water is standard for drinking water and it's color isn't being affected by a substance.";
        }
        break;
      case 1:
        {
          return " that there are air bubbles in the water or some type of white substance. Cloudy water is most commonly caused by air bubbles trapped in the water. If the water does not clear up, it may be contaminated by another substance that might be harmful.";
        }
        break;
      case 2:
        {
          return " that there could be rust in the water supply. If the sample is taken from iron or lead pipes, this may be the case. Rust in water will not cause health issues and could be caused to city water lines or problems in your house. While it is not harmful it will cause stains in clothes so be advised.";
        }
        break;
      case 3:
        {
          return " that there could be rust in the water supply. If the sample is taken from iron or lead pipes, this may be the case. Rust in water will not cause health issues and could be caused to city water lines or problems in your house. While it is not harmful it will cause stains in clothes so be advised.";
        }
        break;
      case 4:
        {
          return " that there could be rust in the water supply. If the sample is taken from iron or lead pipes, this may be the case. Rust in water will not cause health issues and could be caused to city water lines or problems in your house. While it is not harmful it will cause stains in clothes so be advised.";
        }
        break;
      case 5:
        {
          return " that water discoloration might be caused by copper plumbing or brass fittings. If the water sample is from pipes that have copper fittings, this may be the case. This type of water discoloration can cause health problems and needs to be remedied immediately. Excessive amounts of copper in water supply can cause liver, kidney, or gastrointestinal issues.";
        }
        break;
      case 6:
        {
          return " that there could be mold in the water supply and you should have a plumber investigate it. If this is the case, you should not use this water until it has been remedied.";
        }
        break;
      case 7:
        {
          return "  that there is a harmless organism growing in the water that is discoloring it. This causes no health issues.";
        }
        break;
      case 8:
        {
          // https://sciencing.com/effects-algae-drinking-water-7630835.html
          return " that there is algae growing in your water supply. It might be difficult to determine the effects of algae in water without knowing what type it is, but it could be beneficial, neutral, or harmful. You might want to consider getting it assessed";
        }
        break;
    } //switch statement
  }

  @override
  void initState() {
    super.initState();
    _sample = index;

    //pH
    if (userInfo.retrieveList()[_sample].ph >= 6.0 &&
        userInfo.retrieveList()[_sample].ph <= 8.0) {
      pHAnalysis =
          "within the acceptable range. This does not mean that there aren't any contanimates, however, and other factors should always be taken into consideration.";
    } else {
      pHAnalysis =
          "NOT within the acceptable range. As mentioned before, this could mean that there are contanimates in the water, but this doesn't necessarilly mean they would be harmful, and other factors should always be taken into consideration. Generally, however, it is not recommended to use water with a pH outside of the aforementioned guideline.";
    }

    //Hardness
    if (userInfo.retrieveList()[_sample].hardness >= 0 &&
        userInfo.retrieveList()[_sample].hardness <= 60) {
      hardnessAnalysis =
          "(soft water), this means that there is a low level of calcium or magnesium in the water. Like mentioned earlier, hardness does not signify harmful effects but anything excessively hard or excessively soft is unusual.";
    }
    if (userInfo.retrieveList()[_sample].hardness >= 61 &&
        userInfo.retrieveList()[_sample].hardness <= 120) {
      hardnessAnalysis =
          "(moderately hard water), this means that there is a moderate level of calcium or magnesium in the water. Like mentioned earlier, hardness does not signify harmful effects but anything excessively hard or excessively soft is unusual.";
    }
    if (userInfo.retrieveList()[_sample].hardness >= 121 &&
        userInfo.retrieveList()[_sample].hardness <= 200) {
      hardnessAnalysis =
          "(hard water), this means that there is a high level of calcium or magnesium in the water. Like mentioned earlier, hardness does not signify harmful effects but anything excessively hard or excessively soft is unusual.";
    }
    if (userInfo.retrieveList()[_sample].hardness >= 201) {
      hardnessAnalysis =
          "(very hard water), this means that there is a very high level of calcium or magnesium in the water and might not be recommended. Like mentioned earlier, hardness does not signify harmful effects but anything excessively hard or excessively soft is unusual.";
    }

    cAnalysis = colorAnalysis(userInfo.retrieveList()[_sample].color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample Analysis:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Align(
              //Title
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(userInfo.retrieveList()[_sample].name,
                      style: TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w900)))),
          Align(
              //Water Data Sheet
              alignment: Alignment.center,
              child: Card(
                  child: DataTable(
                columnSpacing: 15,
                dividerThickness: 2,
                horizontalMargin: 10,
                showBottomBorder: false,
                columns: const <DataColumn>[
                  DataColumn(
                      label: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  DataColumn(
                      label: Text('pH',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  DataColumn(
                      label: Text('Hardness',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  DataColumn(
                      label: Text('Color',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  DataColumn(
                      label: Text('Location Type',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                ],
                rows: <DataRow>[
                  DataRow(cells: <DataCell>[
                    DataCell(Text(userInfo.retrieveList()[_sample].name,
                        style: TextStyle(fontWeight: FontWeight.w300))),
                    DataCell(Text(
                        userInfo.retrieveList()[_sample].ph.toString(),
                        style: TextStyle(fontWeight: FontWeight.w300))),
                    DataCell(Text(
                        userInfo.retrieveList()[_sample].hardness.toString(),
                        style: TextStyle(fontWeight: FontWeight.w300))),
                    DataCell(Text(
                        findColor(userInfo
                            .retrieveList()[_sample]
                            .color), //new method
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorId(
                                userInfo.retrieveList()[_sample].color)))),
                    DataCell(Text(
                        findType(userInfo
                            .retrieveList()[_sample]
                            .location), //new method
                        style: TextStyle(fontWeight: FontWeight.w600))),
                  ])
                ],
              ))),
          Padding(
              //pH Level title
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("pH Levels:",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              )),
          Padding(
              //pH Level body 1
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "pH testing measures how acidic or alkaline the water sample is. In general, it is safe to assume that a pH Level of 6 - 8 is safe to use. If the water pH is outside of these bounds, it could mean that there are contaminants or substances in the water that are having a substantial effect on the pH Level and may not be safe to use.",
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //pH Level body 2
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Your sample has a pH level of " +
                        userInfo.retrieveList()[_sample].ph.toString() +
                        ", which is " +
                        pHAnalysis,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //Hardness title
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Water Hardness:",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              )),
          Padding(
              //Hardness body 1
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Water hardness is a measure of calcium and magnesium cations in a water sample. It is recorded in either mg/L or ppm. Excessive water hardness is not necessarilly a health threat. It affects water aesthetic and it is common to have a moderate water hardness (a hardness between 60 and 120 ppm).",
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //hardness body 2
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "With a water hardness of " +
                        userInfo.retrieveList()[_sample].color.toString() +
                        "ppm " +
                        hardnessAnalysis,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //Color title
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Water Color:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color:
                            colorId(userInfo.retrieveList()[_sample].color))),
              )),
          Padding(
              //Color body
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Color in water is not always a bad sign but it can indicate different minerals and contaminants in a water sample. For example, pipes made out of iron and lead will color water red, orange, or yellow when it rusts.",
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //hardness body 2
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    findColor(userInfo.retrieveList()[_sample].color) +
                        " water can indicate" +
                        cAnalysis,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //Location title
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Water Type:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    )),
              )),
          Padding(
              //Location body
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "This will be incorporated in a later stage of the app. Your water type can indicate known variables when it comes to water safety and water characteristics, so it is a good place to start if you need to learn more about your water.",
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //Overall title
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Water Score:",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    )),
              )),
          Padding(
              //Overall body
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "This will be incorporated in a later stage of the app. This section will go over the previous settings and give a general conclusion on your water sample. For now, here are some resources that you can use to better assess your water and learn more information about water safety:\n\n",
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )),
          Padding(
              //reference links
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "For home water testing: \nhttps://bit.ly/3gkPSRr (EPA website)\n",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlueAccent)),
              )),
          Padding(
              //reference links
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "For water color: \nhttps://bit.ly/3tp03Ii (ewg) \nhttps://bit.ly/3mOZll9 (femoran) \nhttps://bit.ly/3gmbHzI (algae in water 'siencing')\n",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlueAccent)),
              )),
          Padding(
              //reference links
              padding: EdgeInsets.fromLTRB(30, 5, 30, 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Water test interpretations: \nhttps://bit.ly/32fLnPM (esl)",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlueAccent)),
              ))
        ])));
  }
}
