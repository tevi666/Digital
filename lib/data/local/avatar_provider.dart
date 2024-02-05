import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sobol_digital/data/models/avatar_model.dart';

class AvatarProvider with ChangeNotifier {
  late Box<AvatarModel> _box;
  String? _selectedImagePath;

  String? get selectedImagePath => _selectedImagePath;

  AvatarProvider() {
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AvatarModelAdapter());

    _box = await Hive.openBox<AvatarModel>('avatarBox');
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    final avatarModel = _box.get('selectedAvatar', defaultValue: AvatarModel(selectedImagePath: ''));
    _selectedImagePath = avatarModel!.selectedImagePath;
    notifyListeners();
  }

  Future<void> _saveImagePath(String path) async {
    final avatarModel = AvatarModel(selectedImagePath: path);
    await _box.put('selectedAvatar', avatarModel);
    _loadImagePath();
  }

Future<void> pickImage(ImageSource source) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      print("Picked file path: ${pickedFile.path}");
      await _saveImagePath(pickedFile.path);
    }
  } catch (e) {
    print("Ошибка выбора изображения: $e");
  }
}
}
