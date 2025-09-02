import 'package:equatable/equatable.dart';

class ObatEntity extends Equatable {
  final int? id;
  final int? usersId;
  final String date;
  final String name;
  final String dosis;
  final int type;
  final int? duration;
  final int? status;

  const ObatEntity({
    this.id,
    this.usersId,
    required this.date,
    required this.name,
    required this.dosis,
    required this.type,
    this.duration,
    this.status,
  });

  @override
  List<Object?> get props => [
    id,
    usersId,
    date,
    name,
    dosis,
    type,
    duration,
    status,
  ];
}
