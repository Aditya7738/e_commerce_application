import 'dart:convert';


import 'package:e_commerce_application/src/core/helpers/snackbar_helper.dart';
import 'package:e_commerce_application/src/core/helpers/validation_helper.dart';
import 'package:e_commerce_application/src/core/network/product_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class AddItemPage extends StatefulWidget {
  final Map? product;

  const AddItemPage({super.key, this.product});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;




  @override
  void initState() {
    super.initState();

    final product = widget.product;
    if(product != null){
      isEdit = true;
      final title = product['title'];
      final description = product['description'];

      productNameController.text = title;
      descriptionController.text = description;

    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    late String product_name;
    late String description;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit? "Edit item" : "Add new item"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: productNameController,
                validator: ValidationHelper.checkIsNullOrEmpty,
                decoration: InputDecoration(labelText: "Enter new item name"),
              ),
              SizedBox(height: 20),
              // TextFormField(
              //   controller: priceController,
              //   decoration: InputDecoration(labelText: "Enter price"),
              // ),
              TextFormField(
                controller: descriptionController,
                validator: ValidationHelper.validateDescription,
                decoration:
                    InputDecoration(labelText: "Enter product description"),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
              SizedBox(height: 40),
              ElevatedButton(onPressed:() {

                if (formKey.currentState?.validate() ?? false) {
                  product_name = productNameController.text;
                  description = descriptionController.text;

                  isEdit ? updateData(product_name, description) : submitData(product_name, description);
                }


              },
                  child: Text(isEdit? "Update item" : "Add item")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateData(String product_name, String description) async {

    final product = widget.product;
    if(product == null){
      showErrorMessage(context, message:"You cannot call updated without adding data");
      return;
    }

    final id = product['_id'];


    // final price = priceController.text;

    final body = {
      "title": product_name,
      "description": description,
      "is_completed": false
    };

    final isSuccess = await ProductService.updateProduct(id, body);

    print(isSuccess);

    if(isSuccess){

      showSuccessMessage(context, message:"Update success");
      Navigator.pop(context);

    }else{
      showErrorMessage(context, message:"Not able to update");
    }
  }

  Future<void> submitData(String product_name, String description) async {

    final body = {
      "title": product_name,
      "description": description,
      "is_completed": false
    };

    final isSuccess = await ProductService.createProduct(body);

    print(isSuccess);

    if(isSuccess){
      productNameController.text = '';
      descriptionController.text = '';

      showSuccessMessage(context, message:"Item created");
      Navigator.pop(context);

    }else{
      showErrorMessage(context, message:"Item not created");
    }
  }



}
