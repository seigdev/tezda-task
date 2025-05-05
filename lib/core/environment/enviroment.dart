import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, live }

class EnvironmentPath {
  static late Environment env;

  static void set({required Environment environment}) {
    env = environment;
  }

  static Future<void> load() async {
    if (env == Environment.live) {
      await dotenv.load(fileName: ".env.prod");
      return;
    }
    await dotenv.load(fileName: ".env.dev");
  }

  static final String _liveBaseUrl = dotenv.get("API_BASE_URL");

  static final String _devBaseUrl = dotenv.get("API_BASE_URL");

  static String get baseUrl =>
      env == Environment.live ? _liveBaseUrl : _devBaseUrl;

  static final String androidFirebaseAPIKey =
      dotenv.get("ANDROID_FIREBASE_API_KEY");

  static final String iosFirebaseAPIKey = dotenv.get("IOS_FIREBASE_API_KEY");
}
