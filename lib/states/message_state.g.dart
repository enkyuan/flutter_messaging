// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin  _$MessageState on _MessageState, Store {
  final _$messagesAtom = Atom(name: '_MessageState.threads');

  @override
  Map<String, dynamic> get threads {
    _$messagesAtom.reportRead();
    return super.threads;
  }

  @override
  set threads(Map<String, dynamic> value) {
    _$messagesAtom.reportWrite(value, super.threads, () {
      super.threads = value;
    });
  }

  final _$_MessageStateActionController = ActionController(name: '_MessageState');

  @override
  void refreshMessagesForCurrentUser() {
    final _$actionInfo = _$_MessageStateActionController.startAction(
        name: '_MessageState.refreshMessagesForCurrentUser');
    try {
      return super.refreshMessagesForCurrentUser();
    } finally {
      _$_MessageStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''threads: ${threads}''';
  }
}