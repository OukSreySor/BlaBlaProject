import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const BlaTextField({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Row(
        children: [
          Icon(icon, color: BlaColors.iconNormal),
          SizedBox(width: BlaSpacings.s), 
          Expanded(
            child: Text(
              label,
              style: BlaTextStyles.label.copyWith(color: BlaColors.iconNormal),
            ),
          ),
        ],
      ),
    );
  }
}
