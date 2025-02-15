import 'package:nylo_framework/nylo_framework.dart';

/* Keys
|--------------------------------------------------------------------------
| Storage keys are used to read and write to local storage.
| E.g. static StorageKey coins = "SK_COINS";
| String coins = await Keys.coins.read();
|
| Learn more: https://nylo.dev/docs/6.x/storage#storage-keys
|-------------------------------------------------------------------------- */

class Keys {
  // Define the keys you want to be synced on boot
  static syncedOnBoot() => () async {
        return [
          auth,
          bearerToken,
          // coins.defaultValue(10), // give the user 10 coins by default
          customer,
        ];
      };

  static StorageKey auth = getEnv('SK_USER', defaultValue: 'SK_USER');

  static StorageKey bearerToken = 'SK_BEARER_TOKEN';

  static StorageKey customer = 'SK_CUSTOMER';

  // static StorageKey coins = 'SK_COINS';

  /// Add your storage keys here...
}
