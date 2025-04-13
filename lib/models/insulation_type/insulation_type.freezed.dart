// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insulation_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InsulationType _$InsulationTypeFromJson(Map<String, dynamic> json) {
  return _InsulationType.fromJson(json);
}

/// @nodoc
mixin _$InsulationType {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get insulationThickness => throw _privateConstructorUsedError;
  double get insulationAreaPerMeter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsulationTypeCopyWith<InsulationType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsulationTypeCopyWith<$Res> {
  factory $InsulationTypeCopyWith(
          InsulationType value, $Res Function(InsulationType) then) =
      _$InsulationTypeCopyWithImpl<$Res, InsulationType>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String name,
      double insulationThickness,
      double insulationAreaPerMeter});
}

/// @nodoc
class _$InsulationTypeCopyWithImpl<$Res, $Val extends InsulationType>
    implements $InsulationTypeCopyWith<$Res> {
  _$InsulationTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? insulationThickness = null,
    Object? insulationAreaPerMeter = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      insulationThickness: null == insulationThickness
          ? _value.insulationThickness
          : insulationThickness // ignore: cast_nullable_to_non_nullable
              as double,
      insulationAreaPerMeter: null == insulationAreaPerMeter
          ? _value.insulationAreaPerMeter
          : insulationAreaPerMeter // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsulationTypeImplCopyWith<$Res>
    implements $InsulationTypeCopyWith<$Res> {
  factory _$$InsulationTypeImplCopyWith(_$InsulationTypeImpl value,
          $Res Function(_$InsulationTypeImpl) then) =
      __$$InsulationTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String name,
      double insulationThickness,
      double insulationAreaPerMeter});
}

/// @nodoc
class __$$InsulationTypeImplCopyWithImpl<$Res>
    extends _$InsulationTypeCopyWithImpl<$Res, _$InsulationTypeImpl>
    implements _$$InsulationTypeImplCopyWith<$Res> {
  __$$InsulationTypeImplCopyWithImpl(
      _$InsulationTypeImpl _value, $Res Function(_$InsulationTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? insulationThickness = null,
    Object? insulationAreaPerMeter = null,
  }) {
    return _then(_$InsulationTypeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      insulationThickness: null == insulationThickness
          ? _value.insulationThickness
          : insulationThickness // ignore: cast_nullable_to_non_nullable
              as double,
      insulationAreaPerMeter: null == insulationAreaPerMeter
          ? _value.insulationAreaPerMeter
          : insulationAreaPerMeter // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsulationTypeImpl extends _InsulationType {
  const _$InsulationTypeImpl(
      {@JsonKey(includeIfNull: false) this.id,
      required this.name,
      required this.insulationThickness,
      required this.insulationAreaPerMeter})
      : super._();

  factory _$InsulationTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsulationTypeImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final String name;
  @override
  final double insulationThickness;
  @override
  final double insulationAreaPerMeter;

  @override
  String toString() {
    return 'InsulationType(id: $id, name: $name, insulationThickness: $insulationThickness, insulationAreaPerMeter: $insulationAreaPerMeter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsulationTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.insulationThickness, insulationThickness) ||
                other.insulationThickness == insulationThickness) &&
            (identical(other.insulationAreaPerMeter, insulationAreaPerMeter) ||
                other.insulationAreaPerMeter == insulationAreaPerMeter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, insulationThickness, insulationAreaPerMeter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsulationTypeImplCopyWith<_$InsulationTypeImpl> get copyWith =>
      __$$InsulationTypeImplCopyWithImpl<_$InsulationTypeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InsulationTypeImplToJson(
      this,
    );
  }
}

abstract class _InsulationType extends InsulationType {
  const factory _InsulationType(
      {@JsonKey(includeIfNull: false) final String? id,
      required final String name,
      required final double insulationThickness,
      required final double insulationAreaPerMeter}) = _$InsulationTypeImpl;
  const _InsulationType._() : super._();

  factory _InsulationType.fromJson(Map<String, dynamic> json) =
      _$InsulationTypeImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  String get name;
  @override
  double get insulationThickness;
  @override
  double get insulationAreaPerMeter;
  @override
  @JsonKey(ignore: true)
  _$$InsulationTypeImplCopyWith<_$InsulationTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
