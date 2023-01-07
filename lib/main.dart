import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_riverpod/home_screen.dart';
import 'package:r_riverpod/logger_riverpod.dart';
import 'package:r_riverpod/user.dart';
import 'package:http/http.dart' as http;

// final nameProvider = Provider<String>((ref) => 'hellaloa');
final nameProvider = StateProvider<String>((ref) => '-');
final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);

// use change notifier from flutter sdk itself
final userChangeNotifier = ChangeNotifierProvider.autoDispose(
  (ref) => UserChangeNotifier(),
);

final fetchUserProvider = FutureProvider.autoDispose((ref) {
  const url = 'https://jsonplaceholder.typicode.com/users/1';

  return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
});
// other way of futureProvider
final fetchUserProvider2 = FutureProvider.autoDispose((ref) {
  return UserRepository().fetchUserData();
});
final fetchUserProvider3 = FutureProvider.autoDispose((ref) {
  final userRepo = ref.watch(userRepositoryProvider);

  return userRepo.fetchUserData();
});
final fetchUserProvider4 = FutureProvider.family.autoDispose((ref, String id) {
  // autoDispose: avoid memory leak
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.fetchUserDataById(id);
});

final streamProvider = StreamProvider.autoDispose(
  (ref) async* {
    yield [1, 2];
  },
);

void main() {
  runApp(
    ProviderScope(
      observers: [LoggerRiverpod()],
      overrides: [
        streamProvider.overrideWith((ref) async* {
          yield [0, 1];
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
