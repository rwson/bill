import 'package:scoped_model/scoped_model.dart';

import 'package:bill/http/http-util.dart';
import 'package:bill/bean/cnode.dart';

import 'package:bill/api.dart';

mixin CNodeModel on Model {

  CNodeBean topics = new CNodeBean(false, []);

  getTopics() async {
    try {
    print('getTopics');
    final result = await HttpUtil.request(Api.topics);
    topics = new CNodeBean(
      result['success'],
      result['data']
    );
    print(topics);
    notifyListeners();
    } catch (e) {
      print(e.message);
      print('error');
    }
  }

}

