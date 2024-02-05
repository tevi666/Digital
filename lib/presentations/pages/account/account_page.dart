import 'account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const SizedBox(), const MyAccountInfo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 142,
        leading: _currentIndex > 0
            ? Row(children: [
                const SizedBox(
                  width: 8,
                ),
                GlobalIcon(
                    icons: Icons.arrow_back_ios_new,
                    size: 20,
                    color: AppColors.selected,
                    onTap: () {}),
                const SizedBox(
                  width: 2,
                ),
                const GlobalText(
                    text: 'Мой аккаунт',
                    color: AppColors.selected,
                    size: 16,
                    fontWeight: FontWeight.w400)
              ])
            : null,
        title: _currentIndex > 0
            ? const GlobalText(
                text: 'Аккаунт',
                color: AppColors.text,
                size: 17,
                fontWeight: FontWeight.w600)
            : const SizedBox(),
        elevation: 0.5,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.cursor,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: _currentIndex > 0 ? const Color(0xffE3E3E3) : AppColors.primary,
           iconSize: 21,
          unselectedFontSize: 13,
          selectedFontSize: 13,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.window),
              label: 'Мои проекты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Мой аккаунт',
            ),
          ],
        ),
      ),
    );
  }
}
