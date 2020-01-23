import 'package:bill/bean/reminder.dart';
import 'package:mobx/mobx.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:bill/http/http-util.dart';

import 'package:bill/api.dart';

import 'package:bill/stores/base.dart';

part 'reminder.g.dart';

class ReminderStore = _ReminderStore with _$ReminderStore;

abstract class _ReminderStore extends BaseStore with Store {
  @observable
  List<ReminderItem> reminder = new List();

  @observable
  ReminderItem current;

  @action
  Future<bool> createReminder(Map<String, dynamic> reminder) async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp = await HttpUtil.request(Api.createReminder, reminder, HttpUtil.POST);
      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      BotToast.showText(text: data.message);

      return data.success;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

  Future<bool> updateReminder(Map<String, dynamic> reminder) async {
    try {
      switchLoading(true);
      Map<String, dynamic> resp = await HttpUtil.request(Api.updateReminder, reminder, HttpUtil.PUT);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      BotToast.showText(text: data.message);

      return data.success;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

  @action
  Future<bool> queryReminder([bool toast = false]) async {
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

      if (toast) {
        BotToast.showText(text: data.message);
      }
      return data.success;
    } catch (e) {
      switchLoading(false);
      if (toast) {
        BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      }
      return false;
    }
  }

  @action
  Future<bool> getDetail(String id) async {
    try {
      current = null;

      switchLoading(true);

      Map<String, dynamic> resp = await HttpUtil.request(Api.reminderDetail, {
        'id': id
      }, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        current = new ReminderItem.fromJson(data.data);
      } else {
        BotToast.showText(text: data.message);
      }

      return data.success;
    } catch (e) {
      switchLoading(false);
      BotToast.showText(text: HttpUtil.UNKNOWN_ERROR);
      return false;
    }
  }

}


ReminderStore userStore = new ReminderStore();