import 'package:bill/bean/reminder.dart';
import 'package:mobx/mobx.dart';

import 'package:bill/http/http-util.dart';

import 'package:bill/api.dart';

import 'package:bill/stores/base.dart';
import 'package:bill/bean/reminder.dart';

part 'reminder.g.dart';

class ReminderStore = _ReminderStore with _$ReminderStore;

abstract class _ReminderStore extends BaseStore with Store {
  @observable
  List<ReminderItem> reminder = new List();

  @observable
  ReminderItem current;

  @action
  Future<HttpResponse> createReminder(Map<String, dynamic> data) async {
    switchLoading(true);

    // Map<String, dynamic> resp = await HttpUtil.request(Api.ReminderSet, { 'Reminder': amount }, HttpUtil.POST);
    // HttpResponse data = new HttpResponse.formJson(resp);

    // if (data.success) {
    //   Reminder = amount;
    // }

    // switchLoading(false);

    // return data;
  }

  Future<HttpResponse> updateReminder(Map<String, dynamic> data) async {}

  @action
  Future<HttpResponse> queryReminder() async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp = await HttpUtil.request(Api.queryReminder, {}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      if (data.success) {
        reminder = new List();
        data.data.toList().forEach((json) => {
          reminder.add(new ReminderItem.fromJson(json))
        });
      }

      switchLoading(false);

      return data;
    } catch (e) {
      switchLoading(false);
      print(e.toString());
    }
  }

  @action
  Future<HttpResponse> getDetail(String id) async {
    try {
      current = null;

      switchLoading(true);

      Map<String, dynamic> resp = await HttpUtil.request(Api.reminderDetail, {
        'id': id
      }, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      current = new ReminderItem.fromJson(data.data);

      switchLoading(false);
    } catch (e) {
      switchLoading(false);
      print(e.toString());
    }
  }

}


ReminderStore userStore = new ReminderStore();