import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: TextField(
        onSubmitted: (value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Searching for: $value")));
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.tune),
          hintText: "Search services or technicians...",
        ),
      ),
    );
  }
}
