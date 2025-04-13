// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insulated_pipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InsulatedPipe _$InsulatedPipeFromJson(Map<String, dynamic> json) {
  return _InsulatedPipe.fromJson(json);
}

/// @nodoc
mixin _$InsulatedPipe {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  PipeSize get size => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;
  InsulationType get firstLayerMaterial => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  InsulationType? get secondLayerMaterial => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsulatedPipeCopyWith<InsulatedPipe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsulatedPipeCopyWith<$Res> {
  factory $InsulatedPipeCopyWith(
          InsulatedPipe value, $Res Function(InsulatedPipe) then) =
      _$InsulatedPipeCopyWithImpl<$Res, InsulatedPipe>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      PipeSize size,
      double length,
      InsulationType firstLayerMaterial,
      @JsonKey(includeIfNull: false) InsulationType? secondLayerMaterial});

  $PipeSizeCopyWith<$Res> get size;
  $InsulationTypeCopyWith<$Res> get firstLayerMaterial;
  $InsulationTypeCopyWith<$Res>? get secondLayerMaterial;
}

/// @nodoc
class _$InsulatedPipeCopyWithImpl<$Res, $Val extends InsulatedPipe>
    implements $InsulatedPipeCopyWith<$Res> {
  _$InsulatedPipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? size = null,
    Object? length = null,
    Object? firstLayerMaterial = null,
    Object? secondLayerMaterial = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as PipeSize,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      firstLayerMaterial: null == firstLayerMaterial
          ? _value.firstLayerMaterial
          : firstLayerMaterial // ignore: cast_nullable_to_non_nullable
              as InsulationType,
      secondLayerMaterial: freezed == secondLayerMaterial
          ? _value.secondLayerMaterial
          : secondLayerMaterial // ignore: cast_nullable_to_non_nullable
              as InsulationType?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PipeSizeCopyWith<$Res> get size {
    return $PipeSizeCopyWith<$Res>(_value.size, (value) {
      return _then(_value.copyWith(size: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InsulationTypeCopyWith<$Res> get firstLayerMaterial {
    return $InsulationTypeCopyWith<$Res>(_value.firstLayerMaterial, (value) {
      return _then(_value.copyWith(firstLayerMaterial: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InsulationTypeCopyWith<$Res>? get secondLayerMaterial {
    if (_value.secondLayerMaterial == null) {
      return null;
    }

    return $InsulationTypeCopyWith<$Res>(_value.secondLayerMaterial!, (value) {
      return _then(_value.copyWith(secondLayerMaterial: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InsulatedPipeImplCopyWith<$Res>
    implements $InsulatedPipeCopyWith<$Res> {
  factory _$$InsulatedPipeImplCopyWith(
          _$InsulatedPipeImpl value, $Res Function(_$InsulatedPipeImpl) then) =
      __$$InsulatedPipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      PipeSize size,
      double length,
      InsulationType firstLayerMaterial,
      @JsonKey(includeIfNull: false) InsulationType? secondLayerMaterial});

  @override
  $PipeSizeCopyWith<$Res> get size;
  @override
  $InsulationTypeCopyWith<$Res> get firstLayerMaterial;
  @override
  $InsulationTypeCopyWith<$Res>? get secondLayerMaterial;
}

/// @nodoc
class __$$InsulatedPipeImplCopyWithImpl<$Res>
    extends _$InsulatedPipeCopyWithImpl<$Res, _$InsulatedPipeImpl>
    implements _$$InsulatedPipeImplCopyWith<$Res> {
  __$$InsulatedPipeImplCopyWithImpl(
      _$InsulatedPipeImpl _value, $Res Function(_$InsulatedPipeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? size = null,
    Object? length = null,
    Object? firstLayerMaterial = null,
    Object? secondLayerMaterial = freezed,
  }) {
    return _then(_$InsulatedPipeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as PipeSize,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      firstLayerMaterial: null == firstLayerMaterial
          ? _value.firstLayerMaterial
          : firstLayerMaterial // ignore: cast_nullable_to_non_nullable
              as InsulationType,
      secondLayerMaterial: freezed == secondLayerMaterial
          ? _value.secondLayerMaterial
          : secondLayerMaterial // ignore: cast_nullable_to_non_nullable
              as InsulationType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsulatedPipeImpl extends _InsulatedPipe {
  const _$InsulatedPipeImpl(
      {@JsonKey(includeIfNull: false) this.id,
      required this.size,
      required this.length,
      required this.firstLayerMaterial,
      @JsonKey(includeIfNull: false) this.secondLayerMaterial})
      : super._();

  factory _$InsulatedPipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsulatedPipeImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final PipeSize size;
  @override
  final double length;
  @override
  final InsulationType firstLayerMaterial;
  @override
  @JsonKey(includeIfNull: false)
  final InsulationType? secondLayerMaterial;

  @override
  String toString() {
    return 'InsulatedPipe(id: $id, size: $size, length: $length, firstLayerMaterial: $firstLayerMaterial, secondLayerMaterial: $secondLayerMaterial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsulatedPipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.firstLayerMaterial, firstLayerMaterial) ||
                other.firstLayerMaterial == firstLayerMaterial) &&
            (identical(other.secondLayerMaterial, secondLayerMaterial) ||
                other.secondLayerMaterial == secondLayerMaterial));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, size, length, firstLayerMaterial, secondLayerMaterial);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsulatedPipeImplCopyWith<_$InsulatedPipeImpl> get copyWith =>
      __$$InsulatedPipeImplCopyWithImpl<_$InsulatedPipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InsulatedPipeImplToJson(
      this,
    );
  }
}

abstract class _InsulatedPipe extends InsulatedPipe {
  const factory _InsulatedPipe(
      {@JsonKey(includeIfNull: false)
          final String? id,
      required final PipeSize size,
      required final double length,
      required final InsulationType firstLayerMaterial,
      @JsonKey(includeIfNull: false)
          final InsulationType? secondLayerMaterial}) = _$InsulatedPipeImpl;
  const _InsulatedPipe._() : super._();

  factory _InsulatedPipe.fromJson(Map<String, dynamic> json) =
      _$InsulatedPipeImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  PipeSize get size;
  @override
  double get length;
  @override
  InsulationType get firstLayerMaterial;
  @override
  @JsonKey(includeIfNull: false)
  InsulationType? get secondLayerMaterial;
  @override
  @JsonKey(ignore: true)
  _$$InsulatedPipeImplCopyWith<_$InsulatedPipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
