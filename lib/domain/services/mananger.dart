import '../models/room.dart';

class HospitalManaging {
  final List<Room> emergencyRoom;
  final List<Room> icuRoom;
  final List<Room> generalRoom;

  int emergencyRoomCount = 5;
  int icuRoomCount = 10;
  int generalRoomCount = 20;

  int emergencyRoomNumber = 100;
  int icuRoomNumber = 200;
  int generalRoomNumber = 300;

  HospitalManaging()
      : emergencyRoom = [],
        icuRoom = [],
        generalRoom = [] {
    for (int i = 0; i < emergencyRoomCount; i++) {
      emergencyRoom.add(EmergencyRoom(roomNumber: emergencyRoomNumber));
      emergencyRoomNumber++;
    }
    for (int i = 0; i < icuRoomCount; i++) {
      icuRoom.add(EmergencyRoom(roomNumber: icuRoomNumber));
      icuRoomNumber++;
    }
    for (int i = 0; i < generalRoomCount; i++) {
      generalRoom.add(EmergencyRoom(roomNumber: generalRoomNumber));
      generalRoomNumber++;
    }
    ;
  }
}
