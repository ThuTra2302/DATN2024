import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  static final RemoteConfig _instance = RemoteConfig._internal();

  factory RemoteConfig() => _instance;

  RemoteConfig._internal();

  static late final FirebaseRemoteConfig remoteConfig;

  static Future<void> init() async {
    remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }
}
