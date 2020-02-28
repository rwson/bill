import 'package:bill/stores/bill.dart';
import 'package:bill/stores/limit.dart';
import 'package:bill/stores/reminder.dart';
import 'package:bill/stores/task.dart';
import 'package:bill/stores/user.dart';
import 'package:bill/stores/group.dart';
import 'package:bill/stores/statistics.dart';

BillStore _billStore;
LimitStore _limitStore;
ReminderStore _reminderStore;
TaskStore _taskStore;
UserStore _userStore;
GroupStore _groupStore;
StatisticsStore _statisticsStore;

class AppStores {
  static get userStore => _userStore;

  static get limitStore => _limitStore;

  static get reminderStore => _reminderStore;

  static get taskStore => _taskStore;

  static get billStore => _billStore;

  static get groupStote => _groupStore;

  static get statisticsStore => _statisticsStore;

  static initStores() {
    _userStore = new UserStore();
    _limitStore = new LimitStore();
    _taskStore = new TaskStore();
    _reminderStore = new ReminderStore();
    _billStore = new BillStore();
    _groupStore = new GroupStore();
    _statisticsStore = new StatisticsStore();

    _userStore.ensureLogin();
  }
}
