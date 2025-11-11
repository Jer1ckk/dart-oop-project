import 'package:test/test.dart';
import '../lib/domain/models/bed.dart';
import '../lib/domain/models/enum.dart';
import '../lib/domain/models/patient.dart';
import '../lib/domain/models/room.dart';
import '../lib/domain/services/mananger.dart';

class MockRoom extends Room {
  MockRoom({required RoomType type, required int roomNumber, int bedCount = 2})
      : super(
          roomType: type,
          roomNumber: roomNumber,
          beds: List.generate(bedCount, (_) => Bed()),
        );
}

void main() {
  late HospitalManagement hospital;
  late Patient patientBlack;
  late Patient patientRed;
  late Patient patientYellow;

  setUp(() {
    final rooms = [
      MockRoom(type: RoomType.Emergency, roomNumber: 101),
      MockRoom(type: RoomType.ICU, roomNumber: 201),
      MockRoom(type: RoomType.General, roomNumber: 301),
    ];

    hospital = HospitalManagement(loadedRooms: rooms);

    patientBlack = Patient(
        patientName: 'Black Patient',
        gender: Gender.Male,
        entryDate: DateTime.now(),
        code: PatientCode.Black);

    patientRed = Patient(
        patientName: 'Red Patient',
        gender: Gender.Female,
        entryDate: DateTime.now(),
        code: PatientCode.Red);

    patientYellow = Patient(
        patientName: 'Yellow Patient',
        gender: Gender.Male,
        entryDate: DateTime.now(),
        code: PatientCode.Yellow);
  });

  test('Assign Black patient to Emergency room', () {
    hospital.assignPatient(patientBlack);
    final bed = hospital.findPatientBed(patientBlack);

    expect(bed, isNotNull);
    expect(hospital.emergencyRoom.contains(hospital.findPatientRoom(patientBlack)), isTrue);
  });

  test('Assign Red patient to ICU room', () {
    hospital.assignPatient(patientRed);
    final bed = hospital.findPatientBed(patientRed);

    expect(bed, isNotNull);
    expect(hospital.icuRoom.contains(hospital.findPatientRoom(patientRed)), isTrue);
  });

  test('Assign Yellow patient to General room', () {
    hospital.assignPatient(patientYellow);
    final bed = hospital.findPatientBed(patientYellow);

    expect(bed, isNotNull);
    expect(hospital.generalRoom.contains(hospital.findPatientRoom(patientYellow)), isTrue);
  });

  test('Mark patient as recovered (Green code)', () {
    hospital.assignPatient(patientBlack);
    hospital.updatePatientCode(patientBlack, PatientCode.Green);

    expect(patientBlack.leaveDate, isNotNull);
    expect(hospital.activePatient.contains(patientBlack), isFalse);
    expect(hospital.findPatientBed(patientBlack), isNull);
  });

  test('Move patient between rooms', () {
    hospital.assignPatient(patientRed);
    final targetRoom = hospital.generalRoom.first;
    hospital.movePatientRoom(patientRed, targetRoom);

    expect(hospital.findPatientRoom(patientRed), equals(targetRoom));
    expect(hospital.findPatientBed(patientRed), isNotNull);
  });

  test('Check room availability', () {
    final room = hospital.emergencyRoom.first;
    expect(hospital.isRoomAvailable(room), isTrue);


    for (var bed in room.beds) {
      bed.assignPatient(Patient(
          patientName: 'Dummy',
          gender: Gender.Male,
          entryDate: DateTime.now(),
          code: PatientCode.Black));
    }

    expect(hospital.isRoomAvailable(room), isFalse);
  });

  test('Get room status stats', () {
    hospital.assignPatient(patientBlack);
    hospital.assignPatient(patientRed);
    hospital.assignPatient(patientYellow);

    final stats = hospital.getRoomStatus();
    expect(stats.length, 3);

    final emergencyStats = stats.firstWhere((s) => s.type == RoomType.Emergency);
    expect(emergencyStats.occupied, 1);
    expect(emergencyStats.available, hospital.emergencyRoom.first.beds.length - 1);
  });
}
