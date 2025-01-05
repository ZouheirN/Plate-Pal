import 'package:flutter/material.dart';
import 'package:platepal/features/search/screens/search_screen.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final bool pushReplace;

  const SearchWidget(
    this.searchController, {
    super.key,
    required this.pushReplace,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Search for recipes',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                if (pushReplace) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchController: searchController),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchController: searchController),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
