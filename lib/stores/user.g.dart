// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$loginedAtom = Atom(name: '_UserStore.logined');

  @override
  bool get logined {
    _$loginedAtom.context.enforceReadPolicy(_$loginedAtom);
    _$loginedAtom.reportObserved();
    return super.logined;
  }

  @override
  set logined(bool value) {
    _$loginedAtom.context.conditionallyRunInAction(() {
      super.logined = value;
      _$loginedAtom.reportChanged();
    }, _$loginedAtom, name: '${_$loginedAtom.name}_set');
  }

  final _$userInfoAtom = Atom(name: '_UserStore.userInfo');

  @override
  User get userInfo {
    _$userInfoAtom.context.enforceReadPolicy(_$userInfoAtom);
    _$userInfoAtom.reportObserved();
    return super.userInfo;
  }

  @override
  set userInfo(User value) {
    _$userInfoAtom.context.conditionallyRunInAction(() {
      super.userInfo = value;
      _$userInfoAtom.reportChanged();
    }, _$userInfoAtom, name: '${_$userInfoAtom.name}_set');
  }

  final _$getTopicsAsyncAction = AsyncAction('getTopics');

  @override
  Future getTopics() {
    return _$getTopicsAsyncAction.run(() => super.getTopics());
  }
}
