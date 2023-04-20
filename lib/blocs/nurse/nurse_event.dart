part of 'nurse_bloc.dart';

@immutable
abstract class NurseEvent {}

class AddNurseEvent extends NurseEvent {
  final String name,
      phone,
      email,
      password,
      gender,
      experience,
      qualification,
      dob;
  final int hourlyRate;

  AddNurseEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.gender,
    required this.experience,
    required this.qualification,
    required this.hourlyRate,
    required this.dob,
  });
}

class EditNurseEvent extends NurseEvent {
  final String? password;
  final String name,
      phone,
      email,
      gender,
      experience,
      qualification,
      userId,
      dob;
  final int hourlyRate;

  EditNurseEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    this.password,
    required this.gender,
    required this.experience,
    required this.qualification,
    required this.hourlyRate,
    required this.dob,
  });
}

class DeleteNurseEvent extends NurseEvent {
  final String userId;

  DeleteNurseEvent({required this.userId});
}

class ChangeStatusNurseEvent extends NurseEvent {
  final String userId, status;

  ChangeStatusNurseEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllNurseEvent extends NurseEvent {
  final String? query;

  GetAllNurseEvent({this.query});
}
