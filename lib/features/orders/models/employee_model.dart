class Employee {
  final int id;
  final String name;
  final String phone1;
  final String? phone2;
  final String email;
  final String image;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? buildingName;
  final String? houseNumber;
  final String? apartmentNumber;
  final String? passportNumber;
  final String status;

  Employee({
    required this.id,
    required this.name,
    required this.phone1,
    this.phone2,
    required this.email,
    required this.image,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.buildingName,
    this.houseNumber,
    this.apartmentNumber,
    this.passportNumber,
    required this.status,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'],
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postal_code'],
      buildingName: json['building_name'],
      houseNumber: json['house_number'],
      apartmentNumber: json['apartment_number'],
      passportNumber: json['passport_number'],
      status: json['status'] ?? 'inactive',
    );
  }
}
