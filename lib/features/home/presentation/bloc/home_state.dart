part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// class GetItemsLoadingState extends HomeState {}

// class GetItemsSuccessState extends HomeState {
//   final GetItemsEntity getItemsEntity;

//   const GetItemsSuccessState({required this.getItemsEntity});
// }

// class GetItemsErrorState extends HomeState {
//   final String message;

//   const GetItemsErrorState({required this.message});
// }

class GetItemsState extends HomeState {
  final bool expiringSoonLoading;
  final bool allItemsLoading;

  final String expiringSoonErrorMessage;
  final String allItemsErrorMessage;

  final GetItemsEntity? getItemsEntity;
  final GetExpiringSoonItemsEntity? getExpiringSoonItemsEntity;

  const GetItemsState({
    this.expiringSoonLoading = false,
    this.allItemsLoading = false,
    this.expiringSoonErrorMessage = '',
    this.allItemsErrorMessage = '',
    this.getItemsEntity,
    this.getExpiringSoonItemsEntity,
  });

  GetItemsState copyWith({
    bool? expiringSoonLoading,
    bool? allItemsLoading,
    String? expiringSoonErrorMessage,
    String? allItemsErrorMessage,
    GetItemsEntity? getItemsEntity,
    GetExpiringSoonItemsEntity? getExpiringSoonItemsEntity,
  }) => GetItemsState(
    expiringSoonLoading: expiringSoonLoading ?? this.expiringSoonLoading,
    allItemsLoading: allItemsLoading ?? this.allItemsLoading,
    expiringSoonErrorMessage:
        expiringSoonErrorMessage ?? this.expiringSoonErrorMessage,
    allItemsErrorMessage: allItemsErrorMessage ?? this.allItemsErrorMessage,
    getItemsEntity: getItemsEntity ?? this.getItemsEntity,
    getExpiringSoonItemsEntity:
        getExpiringSoonItemsEntity ?? this.getExpiringSoonItemsEntity,
  );

  @override
  List<Object> get props => [
    expiringSoonLoading,
    allItemsLoading,
    expiringSoonErrorMessage,
    allItemsErrorMessage,
    getItemsEntity ?? GetItemsEntity(),
    getExpiringSoonItemsEntity ?? GetExpiringSoonItemsEntity(),
  ];
}

class GetItemInititalState extends GetItemsState {
  GetItemInititalState()
    : super(
        getExpiringSoonItemsEntity: GetExpiringSoonItemsEntity(),
        getItemsEntity: GetItemsEntity(),
        allItemsErrorMessage: '',
        allItemsLoading: false,
        expiringSoonErrorMessage: '',
        expiringSoonLoading: false,
      );
}
