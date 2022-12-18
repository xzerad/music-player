import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({Key? key, required this.sectionName}) : super(key: key);
  final String sectionName;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(sectionName, style: textTheme.displayMedium,),
         Text("See all", style: textTheme.displaySmall?.copyWith(decoration: TextDecoration.underline),)
      ],
    );
  }
}
