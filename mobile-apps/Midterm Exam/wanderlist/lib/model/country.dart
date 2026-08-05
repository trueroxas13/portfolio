class Country {
  final String name;
  final String code;

  Country({required this.name, required this.code});

  // Factory constructor to create a Country from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }

  // Method to convert a Country instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }

  // Method to create a list of Country objects from a JSON list
  static List<Country> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Country.fromJson(json)).toList();
  }
}
