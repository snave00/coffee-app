part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required HomeProductsStatus homeProductsStatus,
    required HomePromosStatus homePromosStatus,
    required List<ProductEntity> products,
    required List<PromoEntity> promos,
    final String? successMessage,
    final String? errorMessage,
  }) = _HomeState;
}

enum HomeProductsStatus {
  initial,
  getProductsLoading,
  getProductsSuccess,
  failure,
}

enum HomePromosStatus {
  initial,
  getPromosLoading,
  getPromosSuccess,
  failure,
}
