part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductCreateLoading extends ProductState {

  @override
  List<Object> get props => [];
}

class ProductCreateSuccess extends ProductState{


  @override
  List<Object> get props => [];
}

class ProductCreateError extends ProductState{
  final String error;
  const ProductCreateError(this.error);

  @override
  List<Object?> get props => [];
}

class ProductReadLoading extends ProductState{
  @override
  List<Object> get props => [];
}


class ProductReadSuccess extends ProductState{
  List<ProductsModel> listOfProductsModel;

  ProductReadSuccess(this.listOfProductsModel);

  @override
  List<Object> get props => [listOfProductsModel];
}

class ProductReadError extends ProductState{
  final String error;
  const ProductReadError(this.error);
  @override
  List<Object?> get props => [error];
}

class ProductUpdateLoading extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductUpdateSuccess extends ProductState{

  List<ProductsModel> listOfProductsModel;

  ProductUpdateSuccess(this.listOfProductsModel);

  @override
  List<Object> get props => [listOfProductsModel];
}

class ProductUpdateError extends ProductState{
  final String error;
  const ProductUpdateError(this.error);
  @override
  List<Object?> get props => [error];
}

class ProductDeleteLoading extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductDeleteSuccess extends ProductState{

  List<ProductsModel> listOfProductsModel;

  ProductDeleteSuccess(this.listOfProductsModel);

  @override
  List<Object> get props => [listOfProductsModel];
}

class ProductDeleteError extends ProductState{
  final String error;
  const ProductDeleteError(this.error);
  @override
  List<Object?> get props => [error];
}
