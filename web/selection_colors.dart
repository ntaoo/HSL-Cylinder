library selection_colors;
import 'dart:html';
import 'color.dart';

class SelectionColors {

  UListElement get selectionColorsElement => document.query('#selection-colors');

  void add(String colorCode) {
    HslColor hslColor = new HslColor.fromString(colorCode);
    SpanElement removeButton = new SpanElement()
      ..classes.add('remove-button');

    LIElement colorElement = new LIElement();
    colorElement.innerHtml = hslColor.toString();

    if (selectionColorsElement.children.isEmpty) {
      removeButton.nodes.add(new Element.html('<em>All Clear</em>'));
      colorElement
        ..style.backgroundColor = hslColor.toString()
        ..classes.add('selection-color')
        ..classes.add('base-color')
        ..nodes.add(removeButton);
    } else {
      colorElement
        ..style.backgroundColor = hslColor.toString()
        ..classes.add('selection-color')
        ..classes.add('sub-color')
        ..nodes.add(removeButton);
    }

    selectionColorsElement.children.add(colorElement);
  }

  SelectionColors() {

  }
}

