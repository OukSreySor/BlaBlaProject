import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

class RidesPrefInputTile extends StatelessWidget {
  final bool isPlaceHolder;
  final String label;
  final IconData icon;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final VoidCallback? onTap;
  

  const RidesPrefInputTile({
    super.key,
    this.isPlaceHolder = false,
    required this.label,
    required this.icon,
    this.rightIcon,
    this.onRightIconPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color labelColor = isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: BlaColors.iconLight, size: 16),
          title: Text(
            label, 
            style: BlaTextStyles.button.copyWith(color: labelColor)
          ),
          trailing: rightIcon != null ? IconButton(icon: Icon(rightIcon, color: BlaColors.primary, size: 16), onPressed: onRightIconPressed) : null,
          onTap: onTap,
        ),
        BlaDivider(),
      ],
    );
  }
}
