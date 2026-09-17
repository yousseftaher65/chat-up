import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY')
  static final String firebaseAndroidApiKey = _Env.firebaseAndroidApiKey;

  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID')
  static final String firebaseAndroidAppId = _Env.firebaseAndroidAppId;

  @EnviedField(varName: 'FIREBASE_IOS_API_KEY')
  static final String firebaseIosApiKey = _Env.firebaseIosApiKey;

  @EnviedField(varName: 'FIREBASE_IOS_APP_ID')
  static final String firebaseIosAppId = _Env.firebaseIosAppId;

  @EnviedField(varName: 'FIREBASE_IOS_CLIENT_ID')
  static final String firebaseIosClientId = _Env.firebaseIosClientId;

  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID')
  static final String firebaseIosBundleId = _Env.firebaseIosBundleId;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
  static final String firebaseMessagingSenderId =
      _Env.firebaseMessagingSenderId;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID')
  static final String firebaseProjectId = _Env.firebaseProjectId;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET')
  static final String firebaseStorageBucket = _Env.firebaseStorageBucket;

  @EnviedField(varName: 'FIREBASE_WEB_CLIENT_ID')
  static final String firebaseWebClientId = _Env.firebaseWebClientId;
}
