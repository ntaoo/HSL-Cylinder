library color_wheel;
import 'dart:html';
import 'controller.dart';
import 'selection_colors.dart';
import 'chip.dart';
import 'color.dart';

// h length: 36 c length: 10 v length: 10 = 360 chips
// TODO implement tone set like http://creators-manual.com/tone/
// TODO auto generate 1st~5th mutching sub colors for base color

class ColorWheel {
  Controller controller;
  SelectionColors selectionColors;
  List<Chip> chips = [];

  void create() {
    _createChips();

    Element colorWheel = document.query('.circle');
    if (!colorWheel.children.isEmpty) {
      colorWheel.children.clear();
    }
    makeHarmonyDomain();
    colorWheel.children.addAll(chips.mappedBy((chip) => chip.chipElement));
  }

  _createChips() {
    chips.clear();
    List<int> hues = [];
    List<int> saturations = [];
    int lightness = controller.lightness;

    int hue = 0;
    int arcDegree = (360 ~/ controller.hueStep);
    while (hue < 360) {
      hues.add(hue);
      hue += arcDegree;
    }

    int saturation = 100;
    int step = controller.saturationStep * 10;
    int bottom = 100 - step;

    while (saturation > bottom) {
      saturations.add(saturation);
      saturation -= 10;
    }

    int saturationStep = controller.saturationStep;

    for (int saturation in saturations) {
      for (int hue in hues) {
        chips.add(new Chip(chips.length.toString(), saturationStep, hue, saturation, lightness));
      }
    }
  }


//  void update() {
//
//  }
//
//  _updateChips() {
//
//  }

  void makeHarmonyDomain() {
    if (selectionColors.selectionColorsElement.children.isEmpty || controller.colorScheme == 'none') {
      chips.forEach((chip) => chip.makeVisible());
    } else {
      HslColor baseColor = new HslColor.fromString(selectionColors.selectionColorsElement.children.first.style.backgroundColor);
      chips.where((Chip chip) => !chip.hslColor.isHarmoniousWith(baseColor)).forEach((chip) => chip.makeInvisible());
    }
  }

  ColorWheel(Controller controller, SelectionColors selectionColors) {
    this.controller = controller;
    this.selectionColors = selectionColors;
    create();
  }
}
