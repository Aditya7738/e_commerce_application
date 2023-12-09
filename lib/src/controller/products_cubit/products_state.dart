// part of 'products_cubit.dart';
//
// abstract class ProductsState extends Equatable {
//   const ProductsState();
// }
//
// class ProductsInitial extends ProductsState {
//
//   Future<void> getRequest() async {
//     final url = "https://fakestoreapi.com/products/";
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     print(response.body);
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body) as Map;
//       final result = json['products'] as List;
//       print(result);
//       setState(() {
//         isLoading = false;
//         products = result;
//       });
//     } else {}
//   }
//
//   @override
//   List<Object> get props => [];
// }
//
// class ProductsLoading extends ProductsState {
//
//   //defining states
//   @override
//   List<Object> get props => [];
// }
//
// class ProductsSuccess extends ProductsState {
//
//   final List<Contact> contact;
//
//   ProductsSuccess({required this.contact});
//
//   @override
//   List<Object> get props => [contact];
// }
//
// class ProductsError extends ProductsState {
//   @override
//   List<Object> get props => [];
// }
