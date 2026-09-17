import 'dart:convert';

class UserModel {
  final String id;
  final String fullname;
  final String email;
  final bool isOnline;
  final DateTime lastSeen;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    this.isOnline = false,
    DateTime? lastSeen,
  }) : lastSeen = lastSeen ?? DateTime.now();

  UserModel copyWith({
    String? id,
    String? fullname,
    String? email,
    bool? isOnline,
    DateTime? lastSeen,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      isOnline: map['isOnline'] ?? false,
      lastSeen:
          map['lastSeen'] != null ? DateTime.parse(map['lastSeen']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, fullname: $fullname, email: $email, isOnline: $isOnline, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.fullname == fullname &&
        other.email == email &&
        other.isOnline == isOnline &&
        other.lastSeen == lastSeen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        isOnline.hashCode ^
        lastSeen.hashCode;
  }
}