import 'package:flutter/material.dart';

class AccountOptionButton extends StatelessWidget {
  const AccountOptionButton({Key? key, required this.icon, required this.title}) : super(key: key);
  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
          tileColor: const Color(0x414e4e50),
          leading: icon,
          trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white,),
          title: Text(title, style: const TextStyle(color: Colors.white),),
          minLeadingWidth: 30,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
      ),
    );
  }
}
