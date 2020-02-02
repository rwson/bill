import 'package:bill/api.dart';
import 'package:bill/bean/user.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Map<String, dynamic> resp =
        await HttpUtil.request(Api.ensureLogined, {}, HttpUtil.GET);
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
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(
          Api.login,
          {'mobile': mobile, 'password': password, 'device': device},
          HttpUtil.POST);

      switchLoading(false);

      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        logined = true;
        userInfo = new User.fromJson(data.data);
        await setToken(data.data['token']);
      } else {
        logined = false;
        BotToast.showText(text: data.message);
      }

      return logined;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

  @action
  Future<bool> validateCode(String mobile, String code) async {
    try {
      Map<String, dynamic> resp = await HttpUtil.request(
          Api.validateVCode, {'mobile': mobile, 'code': code}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      bool validateSuccess = data.success;

      if (!validateSuccess) {
        BotToast.showText(text: data.message);
      }

      return validateSuccess;
    } catch (e) {
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

  @action
  Future<bool> registerLogin(String mobile, String password,
      [String device]) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(
          Api.registerLogin,
          {'mobile': mobile, 'password': password, 'device': device},
          HttpUtil.POST);
      switchLoading(false);

      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        logined = true;
        userInfo = new User.fromJson(data.data);
        await setToken(data.data['token']);
      } else {
        logined = false;
        BotToast.showText(text: data.message);
      }
      return logined;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

  @action
  Future<bool> forgot(String mobile, String password) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(
          Api.forgot, {'mobile': mobile, 'password': password}, HttpUtil.PUT);
      switchLoading(false);

      HttpResponse data = new HttpResponse.formJson(resp);

      if (!data.success) {
        BotToast.showText(text: data.message);
      }

      return data.success;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }
}

UserStore userStore = new UserStore();
