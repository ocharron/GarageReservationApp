class Role {
  final int? id;
  final String userId;
  final String role;

  const Role (this.id, this.userId, this.role);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'role': role
    };
  }

  Role.fromMap(Map<String, dynamic> roleMap):
    id = roleMap['id'],
    userId = roleMap['userId'],
    role = roleMap['role'];

  @override
  String toString() {
    return '$userId: $role';
  }
}