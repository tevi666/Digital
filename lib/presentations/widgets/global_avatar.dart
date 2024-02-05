// global_avatar.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sobol_digital/data/local/avatar_provider.dart';
import 'package:sobol_digital/presentations/widgets/global_divider.dart';
import 'package:sobol_digital/presentations/widgets/global_text.dart';
import 'package:sobol_digital/utilities/constants/app_colors.dart';

class GlobalAvatar extends StatelessWidget {
  const GlobalAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AvatarProvider>(
      builder: (context, avatarProvider, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.selected),
                    shape: BoxShape.circle,
                    color: AppColors.selected,
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.selected,
                    backgroundImage: avatarProvider.selectedImagePath != null &&
                            File(avatarProvider.selectedImagePath!).existsSync()
                        ? FileImage(File(avatarProvider.selectedImagePath!))
                            as ImageProvider<Object>?
                        : const AssetImage('assets/avatar/avatar.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _showImagePicker(context, avatarProvider);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.circleDots,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.selected,
                            ),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.selected,
                            ),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.selected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImagePicker(
    BuildContext context,
    AvatarProvider avatarProvider,
  ) async {
    showModalBottomSheet(
      backgroundColor: AppColors.circleDots,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            color: AppColors.circleDots,
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: GlobalText(
                  text: 'Выбрать фото',
                  color: AppColors.unselected,
                  size: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const GlobalDivider(),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await avatarProvider.pickImage(ImageSource.camera);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: GlobalText(
                    text: 'Камера',
                    color: AppColors.selected,
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const GlobalDivider(),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await avatarProvider.pickImage(ImageSource.gallery);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: GlobalText(
                    text: 'Галерея Фото',
                    color: AppColors.selected,
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const GlobalDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: GlobalText(
                    text: 'Закрыть',
                    color: AppColors.selected,
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
