import 'package:bill/api.dart';
import 'package:bill/bean/group.dart';
import 'package:bill/http/http-util.dart';
import 'package:bill/stores/base.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:mobx/mobx.dart';

part 'group.g.dart';

class GroupStore = _GroupStore with _$GroupStore;

abstract class _GroupStore extends BaseStore with Store {
  @observable
  List<GroupItem> groups = [];

  @observable
  GroupItem current;

  @action
  Future<bool> createGroup(Map<String, dynamic> group) async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.createGroup, group, HttpUtil.POST);
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
      Map<String, dynamic> resp =
          await HttpUtil.request(Api.updateReminder, reminder, HttpUtil.PUT);

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
  Future<bool> queryGroups([bool toast = false]) async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.queryGroup, {}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);


      if (data.success) {
        groups = new List();
        data.data
            .toList()
            .forEach((json) {
              GroupItem item = new GroupItem.fromJson(json);
              GroupItemUser itemUsers = new GroupItemUser.fromJson(json['uesrs']);
              print(itemUsers);
              groups.add(item);
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
  Future<bool> deleteReminder(String id) async {
    try {
      switchLoading(true);

      Map<String, dynamic> resp =
      await HttpUtil.request(Api.deleteReminder, {
        'id': id
      }, HttpUtil.DELETE);

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
  Future<bool> getDetail(String id) async {
    try {
      current = null;

      switchLoading(true);

      Map<String, dynamic> resp =
          await HttpUtil.request(Api.reminderDetail, {'id': id}, HttpUtil.GET);

      HttpResponse data = new HttpResponse.formJson(resp);

      switchLoading(false);

      if (data.success) {
        // current = new ReminderItem.fromJson(data.data);
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
