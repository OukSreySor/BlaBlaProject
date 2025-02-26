import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';

class TestButtonScreen extends StatelessWidget {
  const TestButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlaButton Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              text: "Primary Button",
              buttonType: ButtonType.primary,
              onPressed: () {},
            ),
            SizedBox(height: BlaSpacings.m),
            BlaButton(
              text: "Secondary Button",
              buttonType: ButtonType.secondary,
              onPressed: () {},
            ),
            SizedBox(height: BlaSpacings.m),
            BlaButton(
              text: "Primary Button",
              buttonType: ButtonType.primary,
              icon: Icons.thumb_up,
              onPressed: () {},
            ),
            SizedBox(height: BlaSpacings.m),
            BlaButton(
              text: "Secondary Button",
              buttonType: ButtonType.secondary,
              icon: Icons.thumb_down,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
