import 'dart:convert';

/// This class is a representation of a water sample collected with Aquasafe.
class Sample {
  String title;
  double pH;
  int hardness;
  int color;
  int location;

  /// Takes in title, pH, hardness, color, and location.
  ///
  /// | Color      | int | Type      |
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
  Sample(String title, double pH, int hardness, int color, int location) {
    this.title = title;
    this.pH = pH;
    this.hardness = hardness;
    this.color = color;
    this.location = location;
  }

  /// This method brings the sample data into a Map<String, dynamic> object.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> out = <String, dynamic>{
      "title": title,
      "pH": pH,
      "hardness": hardness,
      "color": color,
      "location": location
    };
    return out;
  }

  /// This lastly brings that Map<String, dynamic> to JSON to be used to make a
  /// request.
  String toJson() {
    Map<String, dynamic> input = this.toMap();

    return json.encode(this.toMap());
  }

  factory Sample.fromJson(Map<String, dynamic> data) {
    return Sample(data["title"], data["pH"], data["hardness"], data["color"],
        data["location"]);
  }
}
