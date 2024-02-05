// avatar_model.dart
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'avatar_model.g.dart';

@HiveType(typeId: 1)
class AvatarModel extends Equatable {
  const AvatarModel({required this.selectedImagePath});
  
  @HiveField(0)
  final String selectedImagePath;

  @override
  List<Object> get props => [selectedImagePath];
}
