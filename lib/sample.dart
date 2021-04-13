import 'dart:convert';

/// This class is a representation of a water sample collected with Aquasafe.
class Sample {
  String name;
  double ph;
  int hardness;
  int color;
  int location;
  int id;

  /// Takes in name, pH, hardness, color, and location.
  ///
  /// | Color      | int | Location  |
  /// | ---------  | :-: | --------: |
  /// | Clear      | 0   | Unknown   |
  /// | Cloudy     | 1   | Tap       |
  /// | Yellow     | 2   | Well      |
  /// | Orange     | 3   | River     |
  /// | Red        | 4   | Lake      |
  /// | Green-blue | 5   | Rain      |
  /// | Black      | 6   | Stream    |
  /// | Pink       | 7   | Spring    |
  /// | Green      | 8   | Hand pump |
  Sample(String name, double ph, int hardness, int color, int location) {
    this.name = name;
    this.ph = ph;
    this.hardness = hardness;
    this.color = color;
    this.location = location;
  }

  Sample.withID(
      String name, double ph, int hardness, int color, int location, int id) {
    this.name = name;
    this.ph = ph;
    this.hardness = hardness;
    this.color = color;
    this.location = location;
    this.id = id;
  }

  /// This method brings the sample data into a Map<String, dynamic> object.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> out = <String, dynamic>{
      "name": name,
      "ph": ph,
      "hardness": hardness,
      "color": color,
      "location": location,
      "id": id
    };
    return out;
  }

  /// This lastly brings that Map<String, dynamic> to JSON to be used to make a
  /// request.
  String toJson() {
    return json.encode(this.toMap());
  }

  factory Sample.fromJsonWithID(Map<String, dynamic> data) {
    return Sample.withID(data["name"], data["ph"], data["hardness"],
        data["color"], data["location"], data["id"]);
  }
}
