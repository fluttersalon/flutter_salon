import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'data.freezed.dart';
part 'data.g.dart';

Function? toNull(_) => null;

@freezed
class Data with _$Data {
  const Data._(); //メソッド不要の場合、削除
  const factory Data({
    required String title,
    // ↓ だめ
    //@Freezed(toJson: false)
    @JsonKey(toJson: toNull, includeIfNull: false)
    @Default('default')
        String noJson,
    @JsonKey(toJson: toNull, includeIfNull: false) String? noJsonNullable,
    @JsonKey(toJson: toNull, includeIfNull: false)
    @Default([])
        List<String> list,
    @JsonKey(toJson: toNull, includeIfNull: false) List<String>? listNullable,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
