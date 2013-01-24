import 'dart:html';
import 'controller.dart';
import 'color_wheel.dart';
import 'selection_colors.dart';

// TODO color set sharing function.

class HslCylinder {
  Controller controller;
  ColorWheel colorWheel;
  SelectionColors selectionColors;

  void changeColorSchemeHandler() {
    SelectElement colorScheme = document.query('#colorScheme');
    colorScheme.on.change.add((event) {
      controller.colorScheme = colorScheme.options[colorScheme.selectedIndex].value;
      colorWheel.create();
    });
  }

  void changeHueStepHandler() {
    SelectElement hueSteps = document.query('#hueStep');
    hueSteps.on.change.add((event) {
      controller.hueStep = int.parse(hueSteps.options[hueSteps.selectedIndex].value);
      colorWheel.create();
    });
  }

  void changeSaturationStepHandler() {
    SelectElement saturationSteps = document.query('#saturationStep');
    saturationSteps.on.change.add((event) {
      controller.saturationStep = int.parse(saturationSteps.options[saturationSteps.selectedIndex].value);
      colorWheel.create();
    });
  }

  void changeLightnessHandler() {
    InputElement lightness = query("#lightness");
    lightness.on.change.add((Event e) {
      controller.lightness = int.parse(lightness.value);
      colorWheel.create();
    });
  }

  // TODO shift + click then change body.style.backgroundColor
  void addSelectionHandler() {
    Element colorWheel = document.query('.circle');
    colorWheel.on.click.add((Event listener) {
      Element element = listener.target;
      if (element.tagName == 'SPAN') {
        selectionColors.add(element.style.backgroundColor);
        this.colorWheel.makeHarmonyDomain();
      }
    });
  }

  void removeSelectionHandler() {
    UListElement selectionColors = document.query('#selection-colors');
    selectionColors.on.click.add((Event listener) {
      Element element = listener.target;
      if (element.classes.contains('remove-button')) {
        if (element.parent.classes.contains('sub-color')) {
          element.parent.remove();
        } else { //baseColor
          selectionColors.children.clear();
          colorWheel.create();
        }
      }
    });
  }

//  void showHslColorCodeHandler() {
//    UListElement selectionColors = document.query('#selection-colors');
//    selectionColors.on.mouseOver.add((Event listener) {
//      Element element = listener.target;
//      if (element.classes.contains('selection-color')) {
//
//      }
//    });
//  }

  HslCylinder() {
    controller = new Controller();
    selectionColors = new SelectionColors();
    colorWheel = new ColorWheel(controller, selectionColors);
    // event listeners TODO change names.
    changeColorSchemeHandler();
    changeHueStepHandler();
    changeSaturationStepHandler();
    changeLightnessHandler();
    addSelectionHandler();
    removeSelectionHandler();
//    showHslColorCodeHandler();
  }

}

void main() {
  new HslCylinder();
}
