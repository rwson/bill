import 'package:bill/stores/user.dart';

UserStore _userStore;

class AppStores {

  static get userStore => _userStore;

  static initStores() {
    _userStore = new UserStore();

    _userStore.ensureLogin();
  }

}
