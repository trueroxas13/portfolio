class Destination {
  String id, location, description, country, status, image;
  DateTime visitDate;

  Destination(
    {
      required this.id,
      required this.location,
      required this.description,
      required this.country,
      required this.status,
      required this.image,
      required this.visitDate
    }
  );

  factory Destination.fromJson(Map<String, dynamic> json){
    return Destination(
      id: json['id'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      country: json['country'] as String,
      status: json['status'] as String,
      image: json['image'] as String,
      visitDate: DateTime.parse(json['visitDate'])
    );
  }
}