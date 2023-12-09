// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// part 'products_state.dart';
//
// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit() : super(ProductsInitial());
//
//   getRecordData() async {
//     emit(RecordsLoading());
//     RecordsRepository recordsRepository = RecordsRepository();
//     List<Contact>? data = await recordsRepository.getData();
//
//     if(data == null){
//       emit(RecordsError());
//       return;
//     }
//
//
//
//     emit(RecordsSuccess(contact: data));
//
//   }
// }
