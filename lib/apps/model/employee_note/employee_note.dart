// ignore_for_file: unnecessary_null_comparison, avoid_renaming_method_parameters

import 'dart:convert';



class EmployeeNote {
  final String id;
  final DateTime date;
  final String color;
  final String time;
  final String note;
  EmployeeNote({
    required this.id,
    required this.date,
    required this.color,
    required this.time,
    required this.note,
  });

  EmployeeNote copyWith({
    required String id,
    required DateTime date,
    required String color,
    required String time,
    required String note,
  }) {
    return EmployeeNote(
      id: id,
      date: date,
      time: time,
      color: color,
      note: note
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'color' : color,
      'time' : time,
      'note' : note,
      'date' : date,
    };
  }

  factory EmployeeNote.fromJson(Map<String, dynamic> map) {
    return EmployeeNote(
      id: map['id'].toString(),
      date: DateTime.parse(map['date']), 
      color: map['color'], 
      note: map['note'], 
      time: map['time'],
    );
  }

  // factory EmployeeNote.fromJson()
  factory EmployeeNote.fromDS(String id, Map<String, dynamic> data) {
    return EmployeeNote(
      id: id,
      date: DateTime.fromMillisecondsSinceEpoch(data['date']), 
      color: data['color'], 
      note: data['note'], 
      time: data['time'],
    );
  }
  
  String toJson() => json.encode(toMap());
  // List<dynamic> toList => json.decode()

  @override
  String toString() {
    return 'EmployeeNote(id: $id, date: $date, color: $color, note: $note, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmployeeNote &&
        o.id == id &&
        o.date == date &&
        o.color == color &&
        o.note == note &&
        o.time == time;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        date.hashCode ^
        color.hashCode ^
        note.hashCode ^
        time.hashCode;
  }
}

