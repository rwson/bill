class Api {
  static const String base = 'http://169.254.236.116:3000/';

  static const String registerLogin = 'user/register-login';

  static const String login = 'user/login';

  static const String ensureLogined = 'user/ensure-logined';

  static const String getVCode = 'user/get-vcode';

  static const String validateVCode = 'user/validate-vcode/:mobile/:code';

  static const String forgot = 'user/forgot';

  static const String limitSet = 'limit/set';

  static const String limitQuery = 'limit/query';

  static const String createReminder = 'reminder/create';

  static const String updateReminder = 'reminder/update';

  static const String queryReminder = 'reminder/query';

  static const String deleteReminder = 'reminder/delete/:id';

  static const String reminderDetail = 'reminder/detail/:id';

  static const String createTask = 'task/create';

  static const String updateTask = 'task/update';

  static const String queryTask = 'task/query';

  static const String deleteTask = 'task/delete/:id';

  static const String taskDetail = 'task/detail/:id';
}
