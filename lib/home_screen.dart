import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_riverpod/main.dart';
import 'package:r_riverpod/user.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final userName =
        ref.watch(userProvider.select((value) => value.name)); //only watch name

    final userFromInternet = ref.watch(fetchUserProvider);
    userFromInternet.when(
      data: (data) {
        print(data.name);
      },
      error: (error, stackTrace) {
        print('error' + error.toString());
      },
      loading: () {
        print('loading...');
      },
    );

    ref.watch(fetchUserProvider2).whenData((value) {
      print('data2: ${value.name}');
    });

    ref.watch(fetchUserProvider3).whenData(
      (value) {
        print('data3: ${value.name}');
      },
    );

    ref.watch(fetchUserProvider4('2')).whenData((value) {
      print('data4: ${value.name}');
    });

    ref.watch(streamProvider).whenData((value) {
      print('stream: ${value}');
    });

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              // ref.read(nameProvider.notifier).update((state) => value);
            },
            onChanged: (value) {
              ref.read(nameProvider.notifier).update((state) => value);
              ref.read(userProvider.notifier).updateName(value);

              ref.read(userChangeNotifier).updateName(value);
            },
          ),
          Center(
            child: Text(
              ref.watch(nameProvider),
            ),
          ),
          Center(
            child: Text(
              user.name,
            ),
          ),
          Center(
            child: Text(
              userName,
            ),
          ),
          Center(
            child: Text(
              ref.watch(userChangeNotifier).user.name,
            ),
          ),
        ],
      ),
    );
  }
}
