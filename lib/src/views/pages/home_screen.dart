
import 'package:e_commerce_application/src/core/constants/strings.dart';
import 'package:e_commerce_application/src/views/pages/add_item_page.dart';

import 'package:e_commerce_application/src/core/helpers/snackbar_helper.dart';

import 'package:e_commerce_application/src/core/network/product_service.dart';

import 'package:flutter/material.dart';

import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List products = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getRequest();
  }

  Future<void> getRequest() async {
    final response = await ProductService.fetchProducts();

    if (response != null) {
      setState(() {
        isLoading = false;
        products = response;
      });
    } else {
      showErrorMessage(context, message: Strings.notFoundError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E - commerce app"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),

          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddItemPage())).then((value) => getRequest());

          }),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Visibility(
              visible: products.isNotEmpty,
              replacement: Center(
                child: Text(
                  Strings.noProductFoundError,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              child: ListView.builder(
                    itemCount: products.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final product = products[index] as Map;
                      final id = product['_id'] as String;
                      return ProductCard(
                        product: product,
                        deleteById: deleteById,
                      );
                    }),

            ),
    );
  }

  Future<void> deleteById(id) async {
    final isSuccess = await ProductService.deletedById(id);

    if (isSuccess) {
      final filtered =
          products.where((element) => element['_id'] != id).toList();
      setState(() {
        products = filtered;
      });
      showSuccessMessage(context, message: Strings.itemDeletedMsg);
    } else {
      showErrorMessage(context, message: Strings.itemDeleteErrorMsg);
    }
  }
}
