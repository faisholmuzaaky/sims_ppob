part of screen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBalance = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context
          .read<BalanceProvider>()
          .getBalance(token: context.read<AuthProvider>().token);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();
    BalanceProvider balanceProvider = context.read<BalanceProvider>();
    LayananProvider layananProvider = context.read<LayananProvider>();
    BannerProvider bannerProvider = context.read<BannerProvider>();
    //Cek apakah foto profile ada atau tidak
    bool isProfile() {
      int index = authProvider.user.profileImage!.lastIndexOf('/') + 1;
      String fileName = authProvider.user.profileImage!.substring(index);
      if (fileName == 'null') {
        return false;
      } else {
        return true;
      }
    }

    Widget header() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HorizontalLogo(
              imageSize: 24.w,
              fontSize: 16.sp,
              space: 8.w,
            ),
            (isProfile())
                ? Image.network(
                    authProvider.user.profileImage!,
                    width: 32.w,
                  )
                : Image.asset(
                    'assets/Profile Photo.png',
                    width: 32.w,
                  ),
          ],
        ),
      );
    }

    Widget title() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang,',
              style: blackTextStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${authProvider.user.firstName!} ${authProvider.user.lastName!}',
              style: blackTextStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget cardBalance() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo anda',
              style: font.copyWith(
                fontSize: 16.sp,
                fontWeight: semiBold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            //BALANCE
            Row(
              children: [
                balanceProvider.visibility
                    ? Text(
                        NumberFormat.currency(
                          locale: 'id-ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(
                          balanceProvider.balance.balance,
                        ),
                        style: font.copyWith(
                          fontSize: 24.sp,
                          fontWeight: bold,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        children: [
                          Text(
                            'Rp',
                            style: font.copyWith(
                              fontSize: 24.sp,
                              fontWeight: bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Row(
                            children: List.generate(
                              6,
                              (index) => Padding(
                                padding:
                                    EdgeInsets.only(left: index == 0 ? 0 : 4.w),
                                child: Text(
                                  '●',
                                  style: font.copyWith(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Lihat Saldo',
                  style: font.copyWith(
                    fontWeight: medium,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    balanceProvider.showBalance = !balanceProvider.visibility;
                  },
                  child: context.watch<BalanceProvider>().isBalance
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                          size: 20,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget menu() {
      Widget itemMenu(LayananModel layanan) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PembayaranScreen(layanan: layanan),
              )),
          child: Column(
            children: [
              Image.network(
                layanan.serviceIcon!,
                width: 52.w,
              ),
              SizedBox(height: 8.h),
              Text(
                layanan.serviceName!,
                style: blackTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: medium,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return FutureBuilder(
        future: layananProvider.getLayanan(token: authProvider.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (layananProvider.listLayanan.length / 2).floor(),
                  mainAxisSpacing: 4.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 4 / 8,
                ),
                itemCount: layananProvider.listLayanan.length,
                itemBuilder: (context, index) {
                  return itemMenu(layananProvider.listLayanan[index]);
                },
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    Widget banner() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Temukan promo menarik',
              style: blackTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: semiBold,
              ),
            ),
          ),
          SizedBox(height: 18.h),
          FutureBuilder(
            future: bannerProvider.getBanner(token: authProvider.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: bannerProvider.listBanner
                        .map(
                          (item) => Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                item.bannerImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              title(),
              SizedBox(height: 32.h),
              cardBalance(),
              SizedBox(height: 32.h),
              menu(),
              SizedBox(height: 12.h),
              banner(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
