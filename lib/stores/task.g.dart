// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  final _$tasksAtom = Atom(name: '_TaskStore.tasks');

  @override
  List<TaskItem> get tasks {
    _$tasksAtom.context.enforceReadPolicy(_$tasksAtom);
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(List<TaskItem> value) {
    _$tasksAtom.context.conditionallyRunInAction(() {
      super.tasks = value;
      _$tasksAtom.reportChanged();
    }, _$tasksAtom, name: '${_$tasksAtom.name}_set');
  }

  final _$currentAtom = Atom(name: '_TaskStore.current');

  @override
  TaskItem get current {
    _$currentAtom.context.enforceReadPolicy(_$currentAtom);
    _$currentAtom.reportObserved();
    return super.current;
  }

  @override
  set current(TaskItem value) {
    _$currentAtom.context.conditionallyRunInAction(() {
      super.current = value;
      _$currentAtom.reportChanged();
    }, _$currentAtom, name: '${_$currentAtom.name}_set');
  }

  final _$createTaskAsyncAction = AsyncAction('createTask');

  @override
  Future<bool> createTask(Map<String, dynamic> task) {
    return _$createTaskAsyncAction.run(() => super.createTask(task));
  }

  final _$queryTaskAsyncAction = AsyncAction('queryTask');

  @override
  Future<bool> queryTask([bool toast = false]) {
    return _$queryTaskAsyncAction.run(() => super.queryTask(toast));
  }

  final _$getDetailAsyncAction = AsyncAction('getDetail');

  @override
  Future<bool> getDetail(String id) {
    return _$getDetailAsyncAction.run(() => super.getDetail(id));
  }
}
