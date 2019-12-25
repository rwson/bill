import 'package:mobx/mobx.dart';

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
  User userInfo = new User();

  @action
  Future getTopics() async {
    switchLoading(true);

    switchLoading(false);
  }

}
