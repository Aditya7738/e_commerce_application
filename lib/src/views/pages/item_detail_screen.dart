import 'dart:convert';

import 'package:e_commerce_application/src/core/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';
import 'cart_page.dart';

import 'package:http/http.dart' as http;


class ItemDetailScreen extends StatefulWidget {
  final Map? product;

  final bool? isFromCart;

  const ItemDetailScreen({super.key, this.product, this.isFromCart });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  bool isFromCart = false;

  @override
  void initState() {
    if(widget.isFromCart != null){
      isFromCart = widget.isFromCart!;
    }
  }

  @override
  Widget build(BuildContext context) {

    final product = widget.product;
    return Scaffold(
        appBar: AppBar(
          title: Text("Item details"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 8),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${product!['title']}", textAlign: TextAlign.start,),
                    SizedBox(height: 10,),
                    Text("${product['description']}", textAlign: TextAlign.start,),
                    SizedBox(height: 20,),
                     ElevatedButton(

                          onPressed: (){
                            isFromCart ?  removeProductFromCart(product['_id'], product) : addItemToCart(product);
                          },
                          child: Text(isFromCart ? Strings.removeBtnTxt : Strings.addBtnTxt)),

                  ]
              ),
        ),
      );
    }

  Future<void> addItemToCart(Map product) async {
    // final product = widget.product;
    //
    // if(product == null){
    //   showErrorMessage(context, message:"You cannot adding item to cart");
    //   return;
    // }

    final id = product['_id'];

    final body = {
      "title": product['title'],
      "description": product['description'],
      "is_completed": true,

    };

    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);

    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    print(response.statusCode);

    if(response.statusCode == 200){

      showSuccessMessage(context, message: Strings.addItemSuccessMsg);
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (context) => CartPage()));

    }else{
      showErrorMessage(context, message: Strings.addItemUnsuccessMsg);
    }
  }

  Future<void> removeProductFromCart(String id, Map cartItem) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);

    final body = {
      "title": cartItem['title'],
      "description": cartItem['description'],
      "is_completed": false,
    };

    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if(response.statusCode == 200){

      showSuccessMessage(context, message:Strings.removeItemSuccessMsg);
      Navigator.pop(context);

    }else{
      showErrorMessage(context, message:Strings.removeItemUnsuccessMsg);
    }
  }




}

