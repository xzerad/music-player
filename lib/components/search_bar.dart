import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(25))
      ),
      child: TextField(
        cursorColor: Theme.of(context).iconTheme.color,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: "Artist, Track or Album",
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: Theme.of(context).inputDecorationTheme.border,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Theme.of(context).iconTheme.color,
            prefixStyle: TextStyle(color: Theme.of(context).iconTheme.color)
        ),
      ),
    );
  }
}
