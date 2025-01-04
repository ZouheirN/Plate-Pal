import 'package:flutter/material.dart';
import 'package:platepal/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController;

  const SearchScreen({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(searchController),
          ],
        ),
      ),
    );
  }
}
