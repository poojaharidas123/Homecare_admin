part of 'payments_bloc.dart';

@immutable
abstract class PaymentsState {}

class PaymentsInitialState extends PaymentsState {}

class PaymentsLoadingState extends PaymentsState {}

class PaymentsSuccessState extends PaymentsState {
  final List<dynamic> payments;

  PaymentsSuccessState({required this.payments});
}

class PaymentsFailureState extends PaymentsState {
  final String message;

  PaymentsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
