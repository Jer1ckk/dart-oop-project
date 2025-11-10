import 'enum.dart';
import 'Bed.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

abstract class Room {
  final String roomId;
  final int roomNumber;
  final List<Bed> beds;
  final RoomType roomType;

  Room(
      {String? roomId,
      required this.roomNumber,
      required this.beds,
      required this.roomType})
      : roomId = roomId ?? uuid.v4();

  Bed? getAvailableBed() {
    for (var bed in beds) {
      if (bed.bedStatus == BedStatus.Available) return bed;
    }
    return null;
  }
}

class EmergencyRoom extends Room {
  EmergencyRoom({ List<Bed>? beds, required int roomNumber}):
    super(roomType: RoomType.Emergency,
    beds : beds ?? List.generate(RoomType.Emergency.beds,(index) => Bed()),
    roomNumber: roomNumber
  );
}

class ICURoom extends Room {
  ICURoom({ List<Bed>? beds, required int roomNumber}):
    super(roomType: RoomType.Emergency,
    beds : beds ?? List.generate(RoomType.ICU.beds,(index) => Bed()),
    roomNumber: roomNumber
  );
}

class GenetalRoom extends Room {
  GenetalRoom({ List<Bed>? beds, required int roomNumber}):
    super(roomType: RoomType.Emergency,
    beds : beds ?? List.generate(RoomType.General.beds,(index) => Bed()),
    roomNumber: roomNumber
  );
}
