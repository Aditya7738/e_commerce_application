import 'package:flutter/material.dart';

import '../pages/add_item_page.dart';
import '../pages/item_detail_screen.dart';

class ProductCard extends StatelessWidget {

  final Map product;
  final Function(String) deleteById;

  const ProductCard({super.key, required this.product, required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = product['_id'] as String;
    return Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ItemDetailScreen(product: product)));
          },
          title: Text(product['title']),
          subtitle: Text(product['description']),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddItemPage(product: product)));
              } else if (value == 'delete') {
                deleteById(id);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Edit"),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  value: 'delete',
                ),
              ];
            },
          ),
        ));;
  }
}
