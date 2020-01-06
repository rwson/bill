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
    switchLoading(true);

    Map<String, dynamic> resp = await HttpUtil.request(Api.limitSet, { 'limit': amount }, HttpUtil.POST);
    HttpResponse data = new HttpResponse.formJson(resp);

    if (data.success) {
      limit = amount;
    }

    switchLoading(false);

    return data;
  }

    @action
  Future<HttpResponse> queryLimit() async {
    switchLoading(true);
  
    Map<String, dynamic> resp = await HttpUtil.request(Api.limitQuery, {}, HttpUtil.GET);
    HttpResponse data = new HttpResponse.formJson(resp);

    if (data.success) {
      limit = data.data['limit'];
    }

    switchLoading(false);

    return data;
  }

}


LimitStore userStore = new LimitStore();