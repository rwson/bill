import 'package:mobx/mobx.dart';

import 'package:bill/bean/cnode.dart';

import 'package:bill/http/http-util.dart';

import 'package:bill/api.dart';

import 'package:bill/stores/base.dart';

part 'cnode.g.dart';

class CNodeStore = _CNodeStore with _$CNodeStore;

abstract class _CNodeStore extends BaseStore with Store {
  @observable
  CNodeBean nodes = new CNodeBean(false, []);

  @observable
  int count = 0;

  @action
  Future getTopics() async {
    switchLoading(true);
    try {
      nodes = new CNodeBean(false, []);
      final result = await HttpUtil.request(Api.topics);
      if (result['success']) {
        final data = result['data'].toList();
        data.forEach((item) => {
          nodes.topics.add(TopicsItem.fromJson(item))
        });
        nodes.success = true;
      } else {
        nodes.success = false;
      }
      switchLoading(false);
    } catch (e) {
      switchLoading(false);
    }
  }

  int operateCount(String type) {
    if (type == 'add') {
      count += 1;
    } else {
      count -= 1;
    }
    print(count);
  }

}
