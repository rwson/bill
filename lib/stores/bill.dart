import 'package:bill/api.dart';
import 'package:bill/bean/bill.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';

part 'bill.g.dart';

class BillStore = _BillStore with _$BillStore;

abstract class _BillStore extends BaseStore with Store {
  List<BillItem> homeBills = [];

  @action
  Future<bool> createBill(Map<String, dynamic> bill) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(Api.createBill, bill, HttpUtil.POST);
      switchLoading(false);

      HttpResponse data = new HttpResponse.formJson(resp);

      BotToast.showText(text: data.message);

      return data.success;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }


  @action
  Future<void> getMonthBills(Map<String, dynamic> param) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(Api.monthBills, {
        'month': param['month']
      }, HttpUtil.GET);
      switchLoading(false);

      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        homeBills = new List();
        data.data
            .toList()
            .forEach((json) => {homeBills.add(new BillItem.fromJson(json))});
      } else {
        if (param['toast']) {
          BotToast.showText(text: data.message);
        }
      }
    } catch (e) {
      switchLoading(false);
      if (param['toast']) {
        BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      }
    }
  }

}