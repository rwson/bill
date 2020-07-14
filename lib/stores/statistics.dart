import 'package:bill/api.dart';
import 'package:bill/bean/statistics.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';

part 'statistics.g.dart';

class StatisticsStore = _StatisticsStore with _$StatisticsStore;

abstract class _StatisticsStore extends BaseStore with Store {
  @observable
  CompareLastMonth compared;

  @observable
  List<String> years;

  @observable
  YearlyAnalyze yearlyAnalyze;

  @observable
  MonthAnalysis monthAnalysis;

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
      }
      
    } catch (e) {
      compared = null;
      switchLoading(false);
    }
  }

  @action
  Future<void> getBillYears() async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.billYears, {}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        years = [];
        data.data.toList().forEach((year) => {years.add(year as String)});
      } else {
        BotToast.showText(text: data.message);
      }

    } catch (e) {
      years = [];
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
    }
  }

  @action
  Future<void> getYearlyBills(Map<String, dynamic> param) async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp = await HttpUtil.request(Api.yearlyBills, param, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        yearlyAnalyze = new YearlyAnalyze.fromJson(data.data);
      }

    } catch (e) {
      switchLoading(false);
    }
  }

  @action
  Future<bool> getMonthAnalysis() async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.monthAnalyze, {}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        monthAnalysis = new MonthAnalysis.fromJson(data.data);
      }

      return data.success;
    } catch (e) {
      switchLoading(false);

      return false;
    }
  }

}