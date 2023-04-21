part of 'manage_nurse_request_bloc.dart';

@immutable
abstract class ManageNurseRequestEvent {}

class GetAllNurseRequestEvent extends ManageNurseRequestEvent {
  final String? status, query;

  GetAllNurseRequestEvent({
    this.status = 'pending',
    this.query,
  });
}

class AddNurseRequestEvent extends ManageNurseRequestEvent {
  final int patientId;
  final String dateFrom, dateTo, timeFrom, timeTo;

  AddNurseRequestEvent({
    required this.patientId,
    required this.dateFrom,
    required this.dateTo,
    required this.timeFrom,
    required this.timeTo,
  });
}

class DeleteNurseRequestEvent extends ManageNurseRequestEvent {
  final int requestId;

  DeleteNurseRequestEvent({
    required this.requestId,
  });
}

class DeleteAssignNurseRequestEvent extends ManageNurseRequestEvent {
  final int assignNurseRequestId;

  DeleteAssignNurseRequestEvent({
    required this.assignNurseRequestId,
  });
}

class AssignNurseRequestEvent extends ManageNurseRequestEvent {
  final int requestId;
  final String nurseId;

  AssignNurseRequestEvent({
    required this.requestId,
    required this.nurseId,
  });
}

class PayNurseRequestEvent extends ManageNurseRequestEvent {
  final int requestId, amount;

  PayNurseRequestEvent({
    required this.requestId,
    required this.amount,
  });
}

class RejectNurseRequestEvent extends ManageNurseRequestEvent {
  final int requestId;
  final String reason;

  RejectNurseRequestEvent({
    required this.requestId,
    required this.reason,
  });
}
