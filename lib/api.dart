class Api {
  static const String base = 'http://192.168.1.20:3000/';

  //  用户相关

  static const String registerLogin = 'user/register-login';

  static const String login = 'user/login';

  static const String ensureLogined = 'user/ensure-logined';

  static const String getVCode = 'user/get-vcode';

  static const String validateVCode = 'user/validate-vcode/:mobile/:code';

  static const String forgot = 'user/forgot';

  static const String switchDevice = 'user/switch-device/:registrationId';

  //  月度限额相关

  static const String limitSet = 'limit/set';

  static const String limitQuery = 'limit/query';

  //  存钱提醒相关

  static const String createReminder = 'reminder/create';

  static const String updateReminder = 'reminder/update';

  static const String queryReminder = 'reminder/query';

  static const String deleteReminder = 'reminder/delete/:id';

  static const String reminderDetail = 'reminder/detail/:id';

  //  记账任务相关 

  static const String createTask = 'task/create';

  static const String updateTask = 'task/update';

  static const String queryTask = 'task/query';

  static const String deleteTask = 'task/delete/:id';

  static const String taskDetail = 'task/detail/:id';

  //  记账圈子相关

  static const String createGroup = 'group/create';

  static const String updateGroup = 'group/update';

  static const String queryGroup = 'group/list';

  static const String deleteGroup = 'group/delete/:id';

  static const String dispandGroup = 'group/dispand/:id';

  static const String groupDetail = 'group/detail/:id';

  //  记账相关

  static const String createBill = 'bill/create';

  static const String monthBills = 'bill/monthly';

  //  统计相关
  static const String compareLastMonth = 'statistics/compare-lastmonth';

}
