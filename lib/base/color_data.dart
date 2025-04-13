import 'dart:ui';

//Color backGroundColor = "#fcfaf4".toColor();
Color backGroundColor = "#fcfaf4".toColor();
Color greenColor = "#00424F".toColor();
Color whiteColour = "#00424F".toColor();
Color intro1Color = "#FFC8CF".toColor();
Color intro2Color = "#E5ECFF".toColor();
Color intro3Color = "#F7FBCD".toColor();
Color dividerColor = "#E5E8F1".toColor();
Color textColor = "#6E758A".toColor();
Color deatilColor = "#D3DFFF".toColor();
Color listColor = "#EEF1F9".toColor();
Color procced = "#E2EAFF".toColor();
Color success = "#04B155".toColor();
Color completed = "#0085FF".toColor();
Color error = "#FF2323".toColor();
Color blueShadow = "#C8CFE2".toColor();
Color receiverColor = "#E8EEFF".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
