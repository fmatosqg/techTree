import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'OptionModel.g.dart';

abstract class OptionModel implements Built<OptionModel, OptionModelBuilder> {
  OptionModel._();
  factory OptionModel([void Function(OptionModelBuilder) updates]) =
      _$OptionModel;

  static Serializer<OptionModel> get serializer => _$optionModelSerializer;

  @nullable
  String get id;

  @nullable
  String get name;
}

abstract class OptionListModel
    implements Built<OptionListModel, OptionListModelBuilder> {
  OptionListModel._();
  factory OptionListModel([void Function(OptionListModelBuilder) updates]) =
      _$OptionListModel;

  static Serializer<OptionListModel> get serializer =>
      _$optionListModelSerializer;

  @nullable
  String get sectionId;

  @nullable
  BuiltList<OptionModel> get values;
}
