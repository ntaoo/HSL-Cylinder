library chip;
import 'dart:html';
import 'color.dart';

class Chip {
  SpanElement chipElement;
  HslColor hslColor;
  String cssId;
  int saturationStep;

  void createElement() {
    int circleRadius = 300;
    int margin = 2;
    int chipSize = 30 - margin;
    int translateY = -(circleRadius * hslColor.s / 100).toInt();
    String style = '-webkit-transform: rotate(${hslColor.h}deg) translate(0, ${translateY}px) scale(1); '
                   '-moz-transform: rotate(${hslColor.h}deg) translate(0, ${translateY}px) scale(1); '
                   'transform: rotate(${hslColor.h}deg) translate(0, ${translateY}px);';
    chipElement = new SpanElement()
      ..id = cssId
      ..attributes['style'] = style
      ..style.width = '${chipSize}px'
      ..style.height = '${chipSize}px'
      ..style.backgroundColor = hslColor.toString()
      ..style.borderRadius = '4px'
      ..classes.add('chip');
  }

//  void updateElement() {
//
//  }

  void makeInvisible() {
    chipElement.classes.add('color-clash');
  }

  void makeVisible() {
    chipElement.classes.remove('color-clash');
  }

  Chip(String cssId, int saturationStep, int h, int s, int l) {
    this.cssId = cssId;
    this.saturationStep = saturationStep;
    hslColor = new HslColor(h, s, l);
    createElement();
  }

}
