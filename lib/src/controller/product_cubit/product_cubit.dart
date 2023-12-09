import 'package:bloc/bloc.dart';
import 'package:e_commerce_application/src/controller/product_cubit/product_repository.dart';
import 'package:equatable/equatable.dart';

import '../../model/Products.dart';
import '../../model/ProductsModel.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  // getRecordData() async {
  //   emit(RecordsLoading());
  //   RecordsRepository recordsRepository = RecordsRepository();
  //   List<Contact>? data = await recordsRepository.getData();
  //
  //   if(data == null){
  //     emit(RecordsError());
  //     return;
  //   }
  //   emit(RecordsSuccess(contact: data));
  //
  // }

  // getProductData() async{
  //   emit(ProductLoading());
  //
  //   ProductRepository productRepository = ProductRepository();
  //   List<Products>? listOfProducts = await productRepository.getData();
  //
  //   if(listOfProducts == null){
  //     emit(ProductError());
  //     return;
  //   }
  //
  //   emit(ProductSuccess(listOfProducts: listOfProducts));
  // }


  Future<void> readProduct() async {
    try {
      ProductRepository productRepository = ProductRepository();
      ProductsModel productsModel = await productRepository.getAllContact();

        List<Products>? dataRaw = productsModel.products;
        List<ProductsModel>? listOfProductsModel = dataRaw?.map((element) => ProductsModel.fromJson(element)).toList();
        emit(ProductReadSuccess(listOfProductsModel!));

    } catch (e) {
      emit(ProductReadError(e.toString()));
    }
  }


}
