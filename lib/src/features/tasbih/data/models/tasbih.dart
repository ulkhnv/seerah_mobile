class Tasbih {
  int aim;
  int dhikr;

  Tasbih({required this.aim, required this.dhikr});

  factory Tasbih.fromJson(Map<String, dynamic> json) {
    return Tasbih(aim: json["aim"] as int, dhikr: json["dhikr"] as int);
  }

  Map<String, dynamic> toJson() {
    return {"aim": aim, "dhikr": dhikr};
  }
}
