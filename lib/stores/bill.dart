import 'package:bill/api.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';

part 'bill.g.dart';

class BillStore = _BillStore with _$BillStore;

abstract class _BillStore extends BaseStore with Store {
  @observable
  int limit = 0;

  @action
  Future<bool> createPaymentBill(Map<String, dynamic> bill) async {
    try {
      switchLoading(true);
      // Map<String, dynamic> resp = await HttpUtil.request(
      //     Api.limitSet, {'limit': amount}, HttpUtil.POST);
      // switchLoading(false);

      // HttpResponse data = new HttpResponse.formJson(resp);

      // if (data.success) {
      //   limit = amount;
      // }

      return true;
    } catch (e) {
      return false;
    }
  }

  @action
  Future<bool> createIncomeBill(Map<String, dynamic> bill) async {
    try {
      switchLoading(true);
      // Map<String, dynamic> resp = await HttpUtil.request(
      //     Api.limitSet, {'limit': amount}, HttpUtil.POST);
      // switchLoading(false);

      // HttpResponse data = new HttpResponse.formJson(resp);

      // if (data.success) {
      //   limit = amount;
      // }

      return true;
    } catch (e) {
      return false;
    }
  }  

}
