import '../registration.dart';

class PersonalInfoText extends StatelessWidget {
  const PersonalInfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 71.5),
      child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Нажимая на данную кнопку, вы даете\n',
                style: TextStyle(color: AppColors.text, fontSize: 10)),
            TextSpan(
                text: ' согласие на обработку',
                style: TextStyle(color: AppColors.text, fontSize: 10)),
            TextSpan(
                text: ' персональных данных',
                style: TextStyle(color: AppColors.gold, fontSize: 10))
          ])),
    );
  }
}
