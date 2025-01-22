class Seller {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  Seller({required this.id, required this.name, required this.email, required this.phoneNumber, this.imageUrl});

  factory Seller.fromJson(Map<String, dynamic> json, String id) {
    return Seller(
      id: id,
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
