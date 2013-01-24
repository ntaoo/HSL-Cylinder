library color;
import 'dart:math';

// ref : http://paraselene.sourceforge.jp/api2.2/paraselene/Color.html
// TODO add alpha channel

abstract class Color {
  String toString();
  String get hexColor;

  bool isRgbColor(String color) {
    return color.contains('rgb');
  }

  bool isHexColor(String color) {
    return color.contains('#');
  }

  bool isHslColor(String color) {
    return color.contains('hsl');
  }

}

// h : hue
// s : satulation
// l : lightness
class HslColor extends Color {
  num h;
  num s;
  num l;

  HslColor(num h, num s, num l) {
    this.h = h; this.s = s; this.l = l;
  }
  HslColor.fromString(String color) {
    if (isRgbColor(color)) {
      RgbColor rgbColor = new RgbColor.fromString(color);
      HslColor hslColor = rgbColor.toHslColor();
      this.h = hslColor.h;
      this.s = hslColor.s;
      this.l = hslColor.l;
    } else if (isHexColor(color)) {
      // not implemented yet.
    } else if (isHslColor(color)) {
      RegExp exp = new RegExp(r"(\d+)");
      List<Match> matches = exp.allMatches(color);
      this.h = int.parse(matches[0].group(0));
      this.s = int.parse(matches[1].group(0));
      this.l = int.parse(matches[2].group(0));
    }
  }

  String get hexColor => '';

  String toString() => 'hsl($h, $s%, $l%)';
  RgbColor toRgbColor() {

  }

  // Too simple.
  // TODO adapt saturation color scheme pattern
  // TODO research and implement some real harmony theory
  // M&S harmony http://apex.sys.wakayama-u.ac.jp/~apex/spdlab/lecture_color/09Handout2012.pdf
  // Research othe theory
  bool isHarmoniousWith(HslColor hslColor) {
    num hueDifference = (this.h - hslColor.h).abs();
    if (hueDifference >= 180) hueDifference = 360 - hueDifference;
    if (hueDifference <= 5) {
      return true;
    } else if (hueDifference >= 25 && hueDifference <= 43) {
      return true;
    } else if (hueDifference >= 100 && hueDifference <= 180) {
      return true;
    } else {
      return false;
    }
  }
}

// r : red
// g : green
// b : blue
class RgbColor extends Color {
  num r;
  num g;
  num b;

  RgbColor(num r, num g, num b) {
    this.r = r; this.g = g; this.b = b;
  }

  RgbColor.fromString(String rgbColor) {
    RegExp exp = new RegExp(r"(\d+)");
    List<Match> matches = exp.allMatches(rgbColor);
    this.r = int.parse(matches[0].group(0));
    this.g = int.parse(matches[1].group(0));
    this.b = int.parse(matches[2].group(0));
  }

  String get hexColor => '';

  HslColor toHslColor() {
      double _r = r / 255; double _g = g / 255; double _b = b / 255;

      double _max = max(max(_r, _g), _b);
      double _min = min(min(_r, _g), _b);
      double h = 0.0;
      double s = 0.0;
      double l = (_max + _min) / 2;

      if (_max == _min) {
        // do nothing. h and s are achromatic.
      } else {
        double d = _max - _min;
        s = l > 0.5 ? d / (2 - _max - _min) : d / (_max + _min);
        if (_max == _r) {
          h = (_g - _b) / d + (_g < _b ? 6 : 0);
        } else if (_max == _g) {
          h = (_b - _r) / d + 2;
        } else if (_max == _b) {
          h = (_r - _g) / d + 4;
        }
        h /= 6;
      }
      h = (360 * h).round();
      s = (100 * s).round();
      l = (100 * l).round();
      return new HslColor(h.toInt(), s.toInt(), l.toInt());
  }
}
