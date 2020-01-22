import 'package:bill/stores/user.dart';
import 'package:bill/stores/limit.dart';
import 'package:bill/stores/reminder.dart';

UserStore _userStore;
LimitStore _limitStore;
ReminderStore _reminderStore;

class AppStores {

  static get userStore => _userStore;

  static get limitStore => _limitStore;

  static get reminderStore => _reminderStore;

  static initStores() {
    _userStore = new UserStore();
    _limitStore = new LimitStore();
    _reminderStore = new ReminderStore();

    // _userStore.ensureLogin();
  }

}
