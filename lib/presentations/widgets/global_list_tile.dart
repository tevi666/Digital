import '../pages/registration/registration.dart';

class GlobalListTile extends StatelessWidget {
  const GlobalListTile({super.key, required this.leading, required this.onTap, required this.subtitle});
  final Widget leading;
  final VoidCallback onTap;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: AppColors.listTileTrailing))),
        child: ListTile(
          onTap: onTap,
          tileColor: Colors.white,
          leading: leading,
          title: Align(
            alignment: Alignment.topRight,
            child: GlobalText(
              text: subtitle,
              color: AppColors.listTileTrailing,
              size: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: GlobalIcon(
              icons: Icons.arrow_right_outlined,
              size: 40,
              color: AppColors.listTileTrailing,
              onTap: onTap),
        ),
      ),
    );
  }
}
