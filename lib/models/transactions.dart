// ignore: file_names
class Transactions {
  late int? id;
  String name;
  String number;
  String type;
  String checkIn;
  String checkOut;

  Transactions(
      {this.id,
      required this.name,
      required this.number,
      required this.type,
      required this.checkIn,
      required this.checkOut});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'type': type,
      'checkIn': checkIn,
      'checkOut': checkOut
    };
  }
}
