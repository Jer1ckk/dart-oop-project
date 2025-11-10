import 'package:uuid/uuid.dart';
import 'enum.dart';
import 'patient.dart';

var uuid = Uuid();

class Bed {
  final String bedId;
  BedStatus bedStatus;
  Patient? patient;

  Bed({String? bedId, this.bedStatus = BedStatus.Available, this.patient})
      : bedId = bedId ?? uuid.v4();

  void assignPatient(Patient patient){
    this.patient = patient;
    patient.assignBed(bedId);
    bedStatus = BedStatus.Occupied;
  }

  void releasePatient(){
    patient?.releasePatient();
    this.patient = null;
    bedStatus = BedStatus.Available;
  }

}


