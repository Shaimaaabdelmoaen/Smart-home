class User {
  String image;
  String name;
  String email;
  User({
    required this.image,
    required this.name,
    required this.email,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
  }) =>
      User(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,

      };
}
