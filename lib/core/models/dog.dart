class Dog {
  final String name;
  final String picture;

  Dog({required this.name, required this.picture});

  factory Dog.fromJSON(Map<String, dynamic> json) {
    return Dog(
      name: json['name'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'picture': picture,
    };
  }
}
