// class Employee {
//   final int id;
//   final String name;
//   final String phone1;
//   final String? phone2;
//   final String email;
//   final String image;
//   final String? street;
//   final String? city;
//   final String? state;
//   final String? country;
//   final String? postalCode;
//   final String? buildingName;
//   final String? houseNumber;
//   final String? apartmentNumber;
//   final String? passportNumber;
//   final String status;
//
//   Employee({
//     required this.id,
//     required this.name,
//     required this.phone1,
//     this.phone2,
//     required this.email,
//     required this.image,
//     this.street,
//     this.city,
//     this.state,
//     this.country,
//     this.postalCode,
//     this.buildingName,
//     this.houseNumber,
//     this.apartmentNumber,
//     this.passportNumber,
//     required this.status,
//   });
//
//   factory Employee.fromJson(Map<String, dynamic> json) {
//     return Employee(
//       id: json['id'],
//       name: json['name'] ?? '',
//       phone1: json['phone1'] ?? '',
//       phone2: json['phone2'],
//       email: json['email'] ?? '',
//       image: json['image'] ?? '',
//       street: json['street'],
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       postalCode: json['postal_code'],
//       buildingName: json['building_name'],
//       houseNumber: json['house_number'],
//       apartmentNumber: json['apartment_number'],
//       passportNumber: json['passport_number'],
//       status: json['status'] ?? 'inactive',
//     );
//   }
// }
class Employee {
  final int id;
  final String name;
  final String phone1;
  final String? phone2;
  final String email;
  final String? fcmToken;
  final String? password;             // if you ever need it
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? buildingName;
  final String? houseNumber;
  final String? apartmentNumber;
  final String? passportNumber;
  final String image;
  final String status;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? passportExpiryDate;
  final DateTime? visaExpiryDate;
  final String? visaNumber;
  final String? emiratesId;
  final DateTime? emiratesIdExpiryDate;
  final String contractType;
  final DateTime? contractValidity;
  final String encryptedId;

  Employee({
    required this.id,
    required this.name,
    required this.phone1,
    this.phone2,
    required this.email,
    this.fcmToken,
    this.password,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.buildingName,
    this.houseNumber,
    this.apartmentNumber,
    this.passportNumber,
    required this.image,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.passportExpiryDate,
    this.visaExpiryDate,
    this.visaNumber,
    this.emiratesId,
    this.emiratesIdExpiryDate,
    required this.contractType,
    this.contractValidity,
    required this.encryptedId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    DateTime? _parse(String? s) =>
        s == null ? null : DateTime.tryParse(s);

    return Employee(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      phone1: json['phone1'] as String? ?? '',
      phone2: json['phone2'] as String?,
      email: json['email'] as String? ?? '',
      fcmToken: json['fcm_token'] as String?,
      password: json['password'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postal_code'] as String?,
      buildingName: json['building_name'] as String?,
      houseNumber: json['house_number'] as String?,
      apartmentNumber: json['apartment_number'] as String?,
      passportNumber: json['passport_number'] as String?,
      image: json['image'] as String? ?? '',
      status: json['status'] as String? ?? 'inactive',
      deletedAt: _parse(json['deleted_at'] as String?),
      createdAt: _parse(json['created_at'] as String)!,
      updatedAt: _parse(json['updated_at'] as String)!,
      passportExpiryDate: _parse(json['passport_expiry_date'] as String?),
      visaExpiryDate: _parse(json['visa_expiry_date'] as String?),
      visaNumber: json['visa_number'] as String?,
      emiratesId: json['emirates_id'] as String?,
      emiratesIdExpiryDate:
      _parse(json['emirates_id_expiry_date'] as String?),
      contractType: json['contract_type'] as String? ?? '',
      contractValidity: _parse(json['contract_validity'] as String?),
      encryptedId: json['encrypted_id'] as String? ?? '',
    );
  }
}
