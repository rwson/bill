import 'package:bill/stores/cnode.dart';
import 'package:bill/stores/user.dart';

CNodeStore _cNodeStore;
UserStore _userStore;

class AppStores {

  static get cNodeStore => _cNodeStore;

  static get userStore => _userStore;

  static initStores() {
    _cNodeStore = new CNodeStore();
    _userStore = new UserStore();
  }

}
