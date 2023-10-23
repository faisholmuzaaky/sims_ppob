part of screen;

class NavigationScreen extends StatefulWidget {
  final int index;
  const NavigationScreen({super.key, this.index = 0});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int? currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customNavigationBar(),
      body: body(),
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TopUpScreen();
      case 2:
        return const TransaksiScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget customNavigationBar() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: greyColor.withOpacity(0.16),
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              title: 'Home',
              icon: Icon(
                Icons.home,
                color: (currentIndex == 0) ? blackColor : greyColor,
              ),
              index: 0,
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),
            navItem(
              title: 'Top Up',
              icon: Icon(
                Icons.money,
                color: (currentIndex == 1) ? blackColor : greyColor,
              ),
              index: 1,
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
            navItem(
              title: 'Transaction',
              icon: Icon(
                Icons.credit_card,
                color: (currentIndex == 2) ? blackColor : greyColor,
              ),
              index: 2,
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
            navItem(
              title: 'Akun',
              icon: Icon(
                Icons.person,
                color: (currentIndex == 3) ? blackColor : greyColor,
              ),
              index: 3,
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required String title,
    required Widget icon,
    required int index,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          icon,
          SizedBox(height: 4.h),
          Text(
            title,
            style: font.copyWith(
              fontSize: 10.sp,
              fontWeight: medium,
              color: (currentIndex == index) ? blackColor : greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
