// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pipe_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PipeSize _$PipeSizeFromJson(Map<String, dynamic> json) {
  return _PipeSize.fromJson(json);
}

/// @nodoc
mixin _$PipeSize {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get diameter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PipeSizeCopyWith<PipeSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipeSizeCopyWith<$Res> {
  factory $PipeSizeCopyWith(PipeSize value, $Res Function(PipeSize) then) =
      _$PipeSizeCopyWithImpl<$Res, PipeSize>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String label,
      double diameter});
}

/// @nodoc
class _$PipeSizeCopyWithImpl<$Res, $Val extends PipeSize>
    implements $PipeSizeCopyWith<$Res> {
  _$PipeSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? diameter = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      diameter: null == diameter
          ? _value.diameter
          : diameter // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PipeSizeImplCopyWith<$Res>
    implements $PipeSizeCopyWith<$Res> {
  factory _$$PipeSizeImplCopyWith(
          _$PipeSizeImpl value, $Res Function(_$PipeSizeImpl) then) =
      __$$PipeSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String label,
      double diameter});
}

/// @nodoc
class __$$PipeSizeImplCopyWithImpl<$Res>
    extends _$PipeSizeCopyWithImpl<$Res, _$PipeSizeImpl>
    implements _$$PipeSizeImplCopyWith<$Res> {
  __$$PipeSizeImplCopyWithImpl(
      _$PipeSizeImpl _value, $Res Function(_$PipeSizeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? diameter = null,
  }) {
    return _then(_$PipeSizeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      diameter: null == diameter
          ? _value.diameter
          : diameter // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PipeSizeImpl extends _PipeSize {
  const _$PipeSizeImpl(
      {@JsonKey(includeIfNull: false) this.id,
      required this.label,
      required this.diameter})
      : super._();

  factory _$PipeSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PipeSizeImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final String label;
  @override
  final double diameter;

  @override
  String toString() {
    return 'PipeSize(id: $id, label: $label, diameter: $diameter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipeSizeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.diameter, diameter) ||
                other.diameter == diameter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, diameter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PipeSizeImplCopyWith<_$PipeSizeImpl> get copyWith =>
      __$$PipeSizeImplCopyWithImpl<_$PipeSizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PipeSizeImplToJson(
      this,
    );
  }
}

abstract class _PipeSize extends PipeSize {
  const factory _PipeSize(
      {@JsonKey(includeIfNull: false) final String? id,
      required final String label,
      required final double diameter}) = _$PipeSizeImpl;
  const _PipeSize._() : super._();

  factory _PipeSize.fromJson(Map<String, dynamic> json) =
      _$PipeSizeImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  String get label;
  @override
  double get diameter;
  @override
  @JsonKey(ignore: true)
  _$$PipeSizeImplCopyWith<_$PipeSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
