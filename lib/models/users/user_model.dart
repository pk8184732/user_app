class Seller {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  Seller({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
  });

  // Factory constructor for creating a Seller object from a map (Firestore)
  factory Seller.fromJson(Map<String, dynamic> json, String id) {
    return Seller(
      id: id,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      imageUrl: json['imageUrl'], // Nullable value
    );
  }

  // Method to convert a Seller object into a map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl, // Nullable value
    };
  }

  // Method to copy the current Seller object (useful when updating)
  Seller copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? imageUrl,
  }) {
    return Seller(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
