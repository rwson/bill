// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$loadingAtom = Atom(name: '_BaseStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  bool switchLoading(bool isLoading) {
    final _$actionInfo = _$_BaseStoreActionController.startAction();
    try {
      return super.switchLoading(isLoading);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }
}
