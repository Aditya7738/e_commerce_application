import 'package:e_commerce_application/src/core/network/apihelper.dart';
import 'package:e_commerce_application/src/model/ProductsModel.dart';

import '../../model/Products.dart';

class ProductRepository{

  Future<ProductsModel> getAllContact() async{
    ProductsModel productsModel = await ApiHelper().makeGetRequest("products");
    return productsModel;
  }

  // Future<List<Products>?> getData() async {
  //   try{
  //
  //     ProductsModel productsModel = ProductsModel();
  //     List<Products>? productList = productsModel.products;
  //
  //     return productList;
  //
  //   }catch(ex){
  //     print("NULL DATA");
  //     return null;
  //   }
  //   //read file get data as string
  // }
}