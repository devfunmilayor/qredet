import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Placeholder — `AppConfig.useMockAuth` is `true` by default, so this is
/// never evaluated. Run `firebase login` then
/// `dart pub global run flutterfire_cli:flutterfire configure` from the
/// repo root to overwrite this file with real values, then flip
/// `AppConfig.useMockAuth` to `false`.
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase is not configured. Run `flutterfire configure` to generate real firebase_options.dart.',
    );
  }
}
