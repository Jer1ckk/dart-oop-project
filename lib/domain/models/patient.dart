import 'enum.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Patient {
  String patientId;
  String patientName;
  Gender gender;
  DateTime entryDate;
  DateTime? leaveDate;
  PatientCode code;
  String? currentBedId;
  List<String> bedHistory = [];

  Patient({
    String? patientId,
    required this.patientName,
    required this.gender,
    required this.entryDate,
    required this.code,
    this.currentBedId,
  }) : patientId = patientId ?? uuid.v4();

  void uodatePatientCode(PatientCode newCode){
    code = newCode;
  }

  void assignBed(String bedId){
    currentBedId = bedId;
    bedHistory.add(bedId);
  }

  void releasePatient() => currentBedId = null;

}

class PatientLocation{
  final RoomType roomType;
  final String roomId;
  final int roomIndexWithinType;
  final String bedId;
  final int bedIndexwithinRoom;

  PatientLocation({
    required this.roomId,
    required this.roomType,
    required this.roomIndexWithinType,
    required this.bedId,
    required this.bedIndexwithinRoom,
  });
}