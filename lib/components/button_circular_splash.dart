import 'package:flutter/material.dart';

class ButtonCircularSplash extends StatelessWidget {
  const ButtonCircularSplash({Key? key, required this.icon, this.onPress}) : super(key: key);
  final void Function()? onPress;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: (){
          onPress?.call();
        },
        child: icon);
  }
}
