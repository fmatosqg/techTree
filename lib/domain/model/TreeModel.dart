import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'OptionModel.dart';

part 'TreeModel.g.dart';

abstract class TreeModel implements Built<TreeModel, TreeModelBuilder> {
  TreeModel._();
  factory TreeModel([void Function(TreeModelBuilder) updates]) = _$TreeModel;

  static Serializer<TreeModel> get serializer => _$treeModelSerializer;

  @nullable
  BuiltList<SectionModel> get sections;

  @nullable
  BuiltList<OptionListModel> get options;
}
