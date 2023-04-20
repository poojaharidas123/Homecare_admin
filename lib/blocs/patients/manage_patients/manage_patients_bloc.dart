import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_patients_event.dart';
part 'manage_patients_state.dart';

class ManagePatientsBloc
    extends Bloc<ManagePatientsEvent, ManagePatientsState> {
  ManagePatientsBloc() : super(ManagePatientsInitialState()) {
    on<ManagePatientsEvent>((event, emit) async {
      emit(ManagePatientsLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('patients');

      try {
        if (event is GetAllPatientsEvent) {
          // List<dynamic> temp = await supabaseClient.rpc(
          //   'get_patients',
          //   params: {
          //     'query': event.query ?? '',
          //   },
          // );
          List<dynamic> temp = [];

          List<Map<String, dynamic>> patients =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(ManagePatientsSuccessState(patients: patients));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ManagePatientsFailureState(message: e.toString()));
      }
    });
  }
}
