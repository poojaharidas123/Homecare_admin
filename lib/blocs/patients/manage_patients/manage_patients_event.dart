part of 'manage_patients_bloc.dart';

@immutable
abstract class ManagePatientsEvent {}

class GetAllPatientsEvent extends ManagePatientsEvent {
  final String? query;

  GetAllPatientsEvent({this.query});
}
