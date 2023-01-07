import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggerRiverpod extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(
      provider,
      previousValue,
      newValue,
      container,
    );

    print('log: $provider');
  }

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    // TODO: implement didAddProvider
    super.didAddProvider(
      provider,
      value,
      container,
    );
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, container);
  }
}
