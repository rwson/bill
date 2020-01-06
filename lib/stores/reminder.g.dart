// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReminderStore on _ReminderStore, Store {
  final _$reminderAtom = Atom(name: '_ReminderStore.reminder');

  @override
  List<ReminderItem> get reminder {
    _$reminderAtom.context.enforceReadPolicy(_$reminderAtom);
    _$reminderAtom.reportObserved();
    return super.reminder;
  }

  @override
  set reminder(List<ReminderItem> value) {
    _$reminderAtom.context.conditionallyRunInAction(() {
      super.reminder = value;
      _$reminderAtom.reportChanged();
    }, _$reminderAtom, name: '${_$reminderAtom.name}_set');
  }

  final _$currentAtom = Atom(name: '_ReminderStore.current');

  @override
  ReminderItem get current {
    _$currentAtom.context.enforceReadPolicy(_$currentAtom);
    _$currentAtom.reportObserved();
    return super.current;
  }

  @override
  set current(ReminderItem value) {
    _$currentAtom.context.conditionallyRunInAction(() {
      super.current = value;
      _$currentAtom.reportChanged();
    }, _$currentAtom, name: '${_$currentAtom.name}_set');
  }

  final _$createReminderAsyncAction = AsyncAction('createReminder');

  @override
  Future<HttpResponse> createReminder(Map<String, dynamic> data) {
    return _$createReminderAsyncAction.run(() => super.createReminder(data));
  }

  final _$queryReminderAsyncAction = AsyncAction('queryReminder');

  @override
  Future<HttpResponse> queryReminder() {
    return _$queryReminderAsyncAction.run(() => super.queryReminder());
  }

  final _$getDetailAsyncAction = AsyncAction('getDetail');

  @override
  Future<HttpResponse> getDetail(String id) {
    return _$getDetailAsyncAction.run(() => super.getDetail(id));
  }
}
