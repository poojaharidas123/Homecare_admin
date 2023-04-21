import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsInitialState()) {
    on<PaymentsEvent>((event, emit) async {
      emit(PaymentsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable =
          supabaseClient.from('nurse_request_payments');
      List<Map<String, dynamic>> paymentWithTestList = [];
      try {
        List<dynamic> temp = await queryTable.select().order(
              'created_at',
            );

        List<Map<String, dynamic>> payments =
            temp.map((e) => e as Map<String, dynamic>).toList();

        Map<String, dynamic> paymentWithTestMap = {};

        for (Map<String, dynamic> payment in payments) {
          List<dynamic> tempTest = await supabaseClient.rpc(
            'get_nurse_requests',
            params: {
              'search_nurse_request_id': payment['nurse_request_id'],
            },
          );

          Map<String, dynamic> test = tempTest.first as Map<String, dynamic>;

          paymentWithTestMap = {
            'payment': payment,
            'request': test,
          };

          paymentWithTestList.add(paymentWithTestMap);
        }
        Logger().d(paymentWithTestList);
        emit(
          PaymentsSuccessState(
            payments: paymentWithTestList,
          ),
        );
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(PaymentsFailureState(message: e.toString()));
      }
    });
  }
}
