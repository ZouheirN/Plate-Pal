import 'package:flutter/material.dart';
import 'package:platepal/features/search/screens/search_screen.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;

  const SearchWidget(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search for recipes',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(searchController: searchController),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
