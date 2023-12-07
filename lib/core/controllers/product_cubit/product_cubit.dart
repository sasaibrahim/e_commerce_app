import 'package:e_commerce_app/core/controllers/product_cubit/product_states.dart';
import 'package:e_commerce_app/core/network/constants.dart';
import 'package:e_commerce_app/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());

  static ProductCubit get(context) => BlocProvider.of(context);
  LaptopsModel? laptopsModel;

  void getHomeProducts() {
    emit(LoadingFetchProducts());
    DioHelperStore.getData(url: ApiConstants.homeApi).then((value) {
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProducts());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorFetchProducts());
    });
  }
}
