import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';


enum ButtonType {primary, secondary}

class BlaButton extends StatelessWidget {
  final String text;
  final ButtonType buttonType;
  final VoidCallback onPressed;
  final IconData? icon;

  const BlaButton({
    super.key, 
    required this.text, 
    required this.buttonType, 
    required this.onPressed, 
    this.icon
  });

  @override
  Widget build(BuildContext context) {

    final isPrimary = buttonType == ButtonType.primary;
    final buttonColor = isPrimary ? BlaColors.primary : BlaColors.white;
    final textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    final borderColor = isPrimary ? BlaColors.primary : BlaColors.greyLight;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        side: BorderSide(color: borderColor),
        padding: EdgeInsets.symmetric(vertical:BlaSpacings.s, horizontal: BlaSpacings.m),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        )
      ),
      onPressed: onPressed, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) 
            Padding(
              padding: EdgeInsets.only(right: BlaSpacings.s), 
              child: Icon(
                icon,
                color: textColor,
              ),
            ),
          Text(
            text,
            style: BlaTextStyles.button.copyWith(color: textColor), 
          ),
        ],
      )
    );
  }
}