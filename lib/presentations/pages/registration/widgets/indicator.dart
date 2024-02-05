import '../registration.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.child, required this.isCompleted, required this.isActive})
      : super(key: key);
  final Widget child;
  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isCompleted ? Border.all(color: AppColors.check) : null,
            color: isCompleted
                ? AppColors.primary 
                : isActive
                    ? AppColors.gold 
                    : AppColors.indicator, 
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.check
                )
              : child,
        ),
      ],
    );
  }
}