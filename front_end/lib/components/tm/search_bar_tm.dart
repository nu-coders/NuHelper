import 'package:flutter/material.dart';
import 'package:front_end/components/tm/cart.dart';
import 'package:get/get.dart';

import '../../backend/shared_variables.dart';

class SearchBarTM extends SearchDelegate {
  List<dynamic> suggestions;
  final SharedVariables variables = Get.put(SharedVariables());

  SearchBarTM(this.suggestions);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.clear)),
      IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const CoursesCart()),
        icon: const Icon(Icons.shopping_cart),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
        // child: Text("This a serious bug please report\nthx, Devs",
        child: Text(
            "Click on the subject while it's on suggestion\nDon't search for it :)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestion = suggestions.where((res) {
      final result = res.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemBuilder: ((context, index) {
          final course = suggestion[index];
          return ListTile(
            title: Text(course),
            onTap: () {
              query = course.split(" -")[0];
              String response = "Already in your cart";
              if (!variables.coursesCart.contains(query)) {
                variables.coursesCart.add(query);
                response = "Added to your cart";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 1500),
                  content: Text(response),
                ),
              );
            },
          );
        }),
        itemCount: suggestion.length);
  }
}
