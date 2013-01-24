library controller;
import 'dart:html';

class Controller {

  // TODO use data-binding
  String colorScheme = 'default';
  int hueStep = 100;
  int saturationStep = 10;
  int lightness = 50; // %

//  void changeColorScheme() {
//    colorScheme = document.query('#colorScheme option[selected=selected]').text;
//  }
//
//  void changeHueStep() {
//    hueStep = int.parse(document.query('#hueStep option[selected=selected]').text);
//  }
//
//  void changeSaturationStep() {
//    saturationStep = int.parse(document.query('#saturationStep option[selected=selected]').text);
//  }

  Controller() {

  }
}
