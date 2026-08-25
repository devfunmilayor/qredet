class AppConfig {
  const AppConfig._();

  /// Flips the wallet data source between the mock and HTTP implementations
  /// at DI-registration time. Neither the repository nor the UI can tell
  /// which one is answering.
  static const bool useMockHomeData = true;

  /// Same switch for auth. Firebase isn't configured in this repo yet (no
  /// real `firebase_options.dart`) — run `firebase login` then
  /// `dart pub global run flutterfire_cli:flutterfire configure` to
  /// generate one, then flip this to `false`.
  static const bool useMockAuth = true;
}
