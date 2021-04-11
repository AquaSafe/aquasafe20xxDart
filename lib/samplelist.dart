import 'package:flutter/material.dart';
import 'package:aquasafe20xx/sample.dart';

//the sampleList class holds a static array of 'Sample' objects which can be used across the application.
class SampleList {
  static List<Sample> userSamples = [];

  SampleList();

  //add samples to the userSamples list.
  addSample(Sample addition) {
    userSamples.add(addition);
  }
}