import '../account.dart';

class MyAccountInfo extends StatefulWidget {
  const MyAccountInfo({super.key});

  @override
  _MyAccountInfoState createState() => _MyAccountInfoState();
}

class _MyAccountInfoState extends State<MyAccountInfo> {

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of<UserInfoProvider>(context);

    return Column(
      children: [
        const GlobalAvatar(),
        AppSizedBox.t12,
        const GlobalText(
          text: 'apollo@gmail.com',
          color: AppColors.unselected,
          size: 12,
          fontWeight: FontWeight.w500,
        ),
        AppSizedBox.t24,
        GlobalListTile(
          leading: Container(
            alignment: Alignment.center,
            width: 60,
            child: const GlobalText(
              text: 'Имя',
              color: AppColors.text,
              size: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => YourNameAndSurname(
                  title: 'Ваше Имя',
                  initialValue: userInfoProvider.firstName,
                  inputController: TextEditingController(text: userInfoProvider.firstName),
                ),
              ),
            );
            if (result != null && result.isNotEmpty) {
              userInfoProvider.updateFirstName(result);
              setState(() {}); 
            }
          },
          subtitle: userInfoProvider.firstName,
        ),
        GlobalListTile(
          leading: Container(
            alignment: Alignment.center,
            width: 90,
            child: const GlobalText(
              text: 'Фамилия',
              color: AppColors.text,
              size: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => YourNameAndSurname(
                  title: 'Ваша Фамилия',
                  initialValue: userInfoProvider.lastName,
                  inputController: TextEditingController(text: userInfoProvider.lastName),
                ),
              ),
            );
            if (result != null && result.isNotEmpty) {
              userInfoProvider.updateLastName(result);
              setState(() {}); 
            }
          },
          subtitle: userInfoProvider.lastName,
        ),
      ],
    );
  }
}

class YourNameAndSurname extends StatefulWidget {
  const YourNameAndSurname({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.inputController,
  }) : super(key: key);

  final String title;
  final String initialValue;
  final TextEditingController? inputController;

  @override
  _YourNameAndSurnameState createState() => _YourNameAndSurnameState();
}

class _YourNameAndSurnameState extends State<YourNameAndSurname> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 105,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(_textEditingController.text);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppColors.selected,
                ),
                SizedBox(
                  width: 2,
                ),
                GlobalText(
                  text: 'Аккаунт',
                  color: AppColors.selected,
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        title: GlobalText(
          text: widget.title,
          color: AppColors.text,
          size: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.title,
                hintStyle: const TextStyle(
                  color: AppColors.listTileTrailing,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
