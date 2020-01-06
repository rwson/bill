import 'package:mobx/mobx.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bill/bean/user.dart';

import 'package:bill/http/http-util.dart';

import 'package:bill/api.dart';

import 'package:bill/stores/base.dart';

part 'user.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore extends BaseStore with Store {
  @observable
  bool logined = false;

  @observable
  User userInfo;

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('userToken');
    return token;
  }

Future<void> setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  @action
  Future<bool> ensureLogin() async {
    String token = await getToken();

    if (token == null) {
      logined = false;
      return false;
    }

    Map<String, dynamic> resp = await HttpUtil.request(Api.ensureLogined, {} ,HttpUtil.GET);
    HttpResponse data = new HttpResponse.formJson(resp);

    if (data.success) {
      logined = true;
      userInfo = new User.fromJson(data.data);
      await setToken(data.data['token']);
    } else {
      logined = false;
    }

    return logined;
  }

  @action
  Future<bool> login(String mobile, String password, [String device]) async {
    Map<String, dynamic> resp = await HttpUtil.request(Api.login, {
      'mobile': mobile,
      'password': password,
      'device': device
    }, HttpUtil.POST);
    HttpResponse data = new HttpResponse.formJson(resp);

    if (data.success) {
      logined = true;
      userInfo = new User.fromJson(data.data);
      await setToken(data.data['token']);
    } else {
      logined = false;
    }

    return logined;
  }

}


UserStore userStore = new UserStore();