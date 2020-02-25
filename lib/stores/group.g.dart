// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GroupStore on _GroupStore, Store {
  final _$groupsAtom = Atom(name: '_GroupStore.groups');

  @override
  List<GroupItem> get groups {
    _$groupsAtom.context.enforceReadPolicy(_$groupsAtom);
    _$groupsAtom.reportObserved();
    return super.groups;
  }

  @override
  set groups(List<GroupItem> value) {
    _$groupsAtom.context.conditionallyRunInAction(() {
      super.groups = value;
      _$groupsAtom.reportChanged();
    }, _$groupsAtom, name: '${_$groupsAtom.name}_set');
  }

  final _$currentAtom = Atom(name: '_GroupStore.current');

  @override
  GroupItem get current {
    _$currentAtom.context.enforceReadPolicy(_$currentAtom);
    _$currentAtom.reportObserved();
    return super.current;
  }

  @override
  set current(GroupItem value) {
    _$currentAtom.context.conditionallyRunInAction(() {
      super.current = value;
      _$currentAtom.reportChanged();
    }, _$currentAtom, name: '${_$currentAtom.name}_set');
  }

  final _$createGroupAsyncAction = AsyncAction('createGroup');

  @override
  Future<bool> createGroup(Map<String, dynamic> group) {
    return _$createGroupAsyncAction.run(() => super.createGroup(group));
  }

  final _$queryGroupsAsyncAction = AsyncAction('queryGroups');

  @override
  Future<bool> queryGroups([bool toast = false]) {
    return _$queryGroupsAsyncAction.run(() => super.queryGroups(toast));
  }

  final _$deleteReminderAsyncAction = AsyncAction('deleteReminder');

  @override
  Future<bool> deleteReminder(String id) {
    return _$deleteReminderAsyncAction.run(() => super.deleteReminder(id));
  }

  final _$getDetailAsyncAction = AsyncAction('getDetail');

  @override
  Future<bool> getDetail(String id) {
    return _$getDetailAsyncAction.run(() => super.getDetail(id));
  }
}
