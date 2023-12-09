import 'dart:convert';

import 'package:e_commerce_application/src/core/constants/strings.dart';
import 'package:e_commerce_application/src/core/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'home_screen.dart';
import 'item_detail_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List cartItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    const url = "https://api.nstack.in/v1/todos?page=1&limit=20";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'];

      List cartList = [];
      print("cart_result ${result.runtimeType}");
      for (var item in result) {
        if (item['is_completed'] == true) {
          cartList.add(item);
        }
      }

      setState(() {
        isLoading = false;
        cartItems = cartList;
      });

      print(cartItems.length);
    } else {
      showErrorMessage(context, message: Strings.responseNotFoundMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.cartPageTitle),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            final newRoute = MaterialPageRoute(builder: (context) => HomeScreen());

            Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
          }),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Visibility(
              visible: cartItems.isNotEmpty,
              replacement: Center(
                child: Text(
                  Strings.emptyCartMsg,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index] as Map;
                      final id = cartItem['_id'] as String;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemDetailScreen(
                                  product: cartItem, isFromCart: true))).then((value) => fetchData());
                        },
                        title: Text(cartItem['title']),
                        subtitle: Text(cartItem['description']), //
                        trailing: IconButton(
                            onPressed: (){
                              updateAddCartStatus(id, cartItem);
                            }, icon: Icon(Icons.delete, color: Colors.red,))
                      );
                    }),

            ),
    );
  }

  Future<void> updateAddCartStatus(String id, Map cartItem) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);

    final body = {
      "title": cartItem['title'],
      "description": cartItem['description'],
      "is_completed": false,
    };

    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      showSuccessMessage(context, message: Strings.removeItemSuccessMsg);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showErrorMessage(context, message: Strings.removeItemUnsuccessMsg);
    }
  }
}
