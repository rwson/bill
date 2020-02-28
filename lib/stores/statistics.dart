import 'package:bill/api.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';
import 'package:bill/bean/statistics.dart';

part 'statistics.g.dart';

class StatisticsStore = _StatisticsStore with _$StatisticsStore;

abstract class _StatisticsStore extends BaseStore with Store {
  @observable
  CompareLastMonth compared;

  @action
  Future<void> compareLast() async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.compareLastMonth, {}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        compared = new CompareLastMonth.fromJson(data.data);
      } else {
        BotToast.showText(text: data.message);
      }

    } catch (e) {
      print(e);
      compared = null;
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
    }
  }

}