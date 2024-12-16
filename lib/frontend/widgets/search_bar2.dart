import 'package:flutter/material.dart';

class SearchBar2 extends StatelessWidget {
  const SearchBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 5), // Add margin here
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          border: OutlineInputBorder( // Change border to OutlineInputBorder
            borderRadius: BorderRadius.circular(50), // Add rounded edges
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: const Align(  
            widthFactor: 1,
            heightFactor: 1,
            child: Icon(
              Icons.search,
              color: Color(0xFFD9D9D9),
            ),
          ),
        ),
      ),
    );
  }
}