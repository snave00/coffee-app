import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/usecases/usecase.dart';
import '../../../utils/enums/product_category_enum.dart';
import '../../product/domain/entities/product_entity.dart';
import '../../product/domain/params/products_params.dart';
import '../../product/domain/usecases/get_products_usecase.dart';
import '../../promos/domain/entities/promo_entity.dart';
import '../../promos/domain/usecases/get_promos_usecase.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final GetPromosUseCase getPromosUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getPromosUseCase,
  }) : super(HomeState(
          homeProductsStatus: HomeProductsStatus.initial,
          homePromosStatus: HomePromosStatus.initial,
          products: [],
          promos: [],
        ));

  void init() async {
    // don't put await so both will load at the same time
    _getProducts();
    _getPromos();
  }

  Future<void> _getProducts() async {
    _loadingProducts();
    final result = await getProductsUseCase.call(
      ProductParams(
        productCategoryId: ProductCategoryEnum.all.name,
        isPopular: true,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          homeProductsStatus: HomeProductsStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            homeProductsStatus: HomeProductsStatus.getProductsSuccess,
            products: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  Future<void> _getPromos() async {
    _loadingPromo();
    // await Future.delayed(const Duration(seconds: 2));
    final result = await getPromosUseCase.call(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          homePromosStatus: HomePromosStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            homePromosStatus: HomePromosStatus.getPromosSuccess,
            promos: success,
            errorMessage: '',
          ),
        );
      },
    );
  }

  void _loadingProducts() {
    emit(state.copyWith(
      homeProductsStatus: HomeProductsStatus.getProductsLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }

  void _loadingPromo() {
    emit(state.copyWith(
      homePromosStatus: HomePromosStatus.getPromosLoading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
