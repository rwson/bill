import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';

import 'package:bill/http/http-util.dart';

import 'package:bill/api.dart';

import 'package:bill/stores/base.dart';

part 'limit.g.dart';

class LimitStore = _LimitStore with _$LimitStore;

abstract class _LimitStore extends BaseStore with Store {
  @observable
  int limit = 0;

  @action
  Future<HttpResponse> setLimit(int amount) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(Api.limitSet, { 'limit': amount }, HttpUtil.POST);
      switchLoading(false);
      
      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        limit = amount;
      }

      return data;
    } catch (e) {

    }
  }

    @action
  Future<bool> queryLimit([bool toast = false]) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(Api.limitQuery, {}, HttpUtil.GET);
      switchLoading(false);
      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        limit = data.data['limit'];
      } else {
        BotToast.showText(text: data.message);
      }

      return data.success;
    } catch (e) {
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
    }
  }

}


LimitStore userStore = new LimitStore();