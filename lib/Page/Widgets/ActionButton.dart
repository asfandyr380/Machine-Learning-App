import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config.dart';

class ActionButton extends StatelessWidget {
  final bool isPlayButton;
  final Function onTap;
  final String svgPath;
  final String tag;
  ActionButton({this.onTap, this.isPlayButton, this.svgPath, this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPlayButton ? 70 : 50,
      width: isPlayButton ? 70 : 50,
      margin: EdgeInsets.only(top: isPlayButton ? 60 : 170),
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: tag,
          onPressed: onTap,
          elevation: 5,
          backgroundColor: textandButton,
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
