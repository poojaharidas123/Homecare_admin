import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:homecare_admin/util/iterable_extension.dart';

part 'manage_nurse_request_event.dart';
part 'manage_nurse_request_state.dart';

class ManageNurseRequestBloc
    extends Bloc<ManageNurseRequestEvent, ManageNurseRequestState> {
  ManageNurseRequestBloc() : super(ManageNurseRequestInitialState()) {
    on<ManageNurseRequestEvent>((event, emit) async {
      emit(ManageNurseRequestLoadingState());
      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder nurseRequestsTable =
            supabaseClient.from('nurse_requests');
        SupabaseQueryBuilder paymentTable =
            supabaseClient.from('nurse_request_payments');

        if (event is GetAllNurseRequestEvent) {
          List<dynamic> nurseRequests = await supabaseClient.rpc(
            'get_nurse_requests',
            params: {
              'search_status': event.status,
              'search_query': event.query,
            },
          );

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<dynamic> modifiedNurseRequests = [];

          for (int i = 0; i < nurseRequests.length; i++) {
            dynamic tempItem = nurseRequests[i];

            if (tempItem['assigned_nurse']['name'] != null) {
              User? user = users.firstOrNull(
                  (user) => user.id == tempItem['assigned_nurse']['user_id']);

              tempItem['assigned_nurse']['status'] =
                  user != null ? user.userMetadata!['status'] : '';
              tempItem['assigned_nurse']['email'] =
                  user != null ? user.email : '';
            }
            modifiedNurseRequests.add(tempItem);
          }
          Logger().w(modifiedNurseRequests);
          emit(ManageNurseRequestSuccessState(requests: modifiedNurseRequests));
        } else if (event is AddNurseRequestEvent) {
          await nurseRequestsTable.insert(
            {
              'user_id': supabaseClient.auth.currentUser!.id,
              'patient_id': event.patientId,
              'date_start': event.dateFrom,
              'date_end': event.dateTo,
              'time_start': event.timeFrom,
              'time_end': event.timeTo,
            },
          );
          add(GetAllNurseRequestEvent());
        } else if (event is DeleteNurseRequestEvent) {
          await nurseRequestsTable.delete().eq('id', event.requestId);
          add(GetAllNurseRequestEvent());
        } else if (event is AssignNurseRequestEvent) {
          await supabaseClient.from('nurse_assign_requests').insert({
            'nurse_request_id': event.requestId,
            'nurse_id': event.nurseId,
          });
          add(GetAllNurseRequestEvent());
        } else if (event is DeleteAssignNurseRequestEvent) {
          await supabaseClient
              .from('nurse_assign_requests')
              .delete()
              .eq('id', event.assignNurseRequestId);
          add(GetAllNurseRequestEvent());
        } else if (event is PayNurseRequestEvent) {
          await paymentTable.insert(
            {
              'nurse_request_id': event.requestId,
              'amount': event.amount,
            },
          );
          add(GetAllNurseRequestEvent(status: 'active'));
        } else if (event is RejectNurseRequestEvent) {
          await nurseRequestsTable.update(
            {
              'reason': event.reason,
              'status': 'rejected',
            },
          ).eq('id', event.requestId);
          add(GetAllNurseRequestEvent(status: 'active'));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ManageNurseRequestFailureState(message: e.toString()));
      }
    });
  }
}
