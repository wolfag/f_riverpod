import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final int? age;
  User({
    required this.name,
    this.age,
  });

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      age: map['age'] != null ? map['age'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, age: $age)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(
          User(name: '', age: 0),
        ) {
    updateName('aa');
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }
}

// use change notifier from flutter sdk itself
class UserChangeNotifier extends ChangeNotifier {
  User user = User(name: '', age: 0);

  void updateName(String name) {
    user = user.copyWith(name: name);
    notifyListeners();
  }
}

// class support for futureProvider
class UserRepository {
  Future<User> fetchUserData() {
    const url = 'https://jsonplaceholder.typicode.com/users/1';

    return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
  }

  Future<User> fetchUserDataById(String id) {
    var url = 'https://jsonplaceholder.typicode.com/users/${id}';

    return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
  }
}

final userRepositoryProvider = Provider.autoDispose((ref) => UserRepository());
