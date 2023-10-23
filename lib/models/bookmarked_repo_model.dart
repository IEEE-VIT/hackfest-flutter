class BookmarkedRepository {
  BookmarkedRepository({
    required this.fullName,
    required this.description,
    required this.link,
    required this.owner,
    required this.name,
    required this.avatarUrl,
  });

  // Create a factory constructor to create an object from a map
  factory BookmarkedRepository.fromMap(Map<String, dynamic> map) {
    return BookmarkedRepository(
      fullName: map['fullName'],
      description: map['description'],
      link: map['link'],
      owner: map['owner'],
      name: map['name'],
      avatarUrl: map['avatarUrl'],
    );
  }
  final String fullName;
  final String? description;
  final String link;
  final String owner;
  final String name;
  final String avatarUrl;

  // Create a method to convert the object to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'description': description,
      'link': link,
      'owner': owner,
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }
}
