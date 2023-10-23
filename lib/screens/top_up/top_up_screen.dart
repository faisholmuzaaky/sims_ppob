part of screen;

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nominalController = TextEditingController();
  bool isActiveButton = false;

  @override
  Widget build(BuildContext context) {
    BalanceProvider balanceProvider = context.read<BalanceProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    showDialogTopUp({
      required String nominal,
      required String type,
    }) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: (type == 'topup') ? 320.h : 300.h,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  if (type == 'topup')
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                        image: const DecorationImage(
                          image: AssetImage('assets/Logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (type == 'berhasil')
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greenColor,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  if (type == 'gagal')
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  SizedBox(height: 24.h),
                  Text(
                    (type == 'topup')
                        ? 'Anda yakin untuk Top Up sebesar'
                        : 'Top Up sebesar',
                    style: blackTextStyle,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    NumberFormat.currency(
                      locale: 'id-ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(
                      num.parse(nominal),
                    ),
                    style: blackTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                  if (type != 'topup')
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        (type == 'berhasil') ? 'berhasil' : 'Gagal',
                        style: blackTextStyle,
                      ),
                    ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () async {
                      if (type == 'topup') {
                        Navigator.pop(context);
                        final result = await balanceProvider.topUp(
                          token: authProvider.token,
                          nominal: num.parse(nominalController.text),
                        );
                        if (result is bool && result) {
                          showDialogTopUp(
                            nominal: nominalController.text,
                            type: 'berhasil',
                          );
                        } else {
                          showDialogTopUp(
                            nominal: nominalController.text,
                            type: 'gagal',
                          );
                        }
                        setState(() {});
                      } else if (type == 'berhasil' || type == 'gagal') {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      (type == 'topup')
                          ? 'Ya, lanjutkan Top Up'
                          : 'Kembali ke Beranda',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  if (type == 'topup') SizedBox(height: 24.h),
                  if (type == 'topup')
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Batalkan',
                        style: greyTextStyle.copyWith(
                          fontWeight: semiBold,
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

    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Top Up',
          style: blackTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: semiBold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: blackColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Kembali',
                  style: blackTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: medium,
                  ),
                )
              ],
            ),
          ),
        ),
        leadingWidth: 120,
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
            Text(
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
          ],
        ),
      );
    }

    Widget title() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 48.h,
          horizontal: 24.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Silahkan masukan',
              style: blackTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Nominal Top Up',
              style: blackTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget topUp() {
      Widget nominal(num nominal) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isActiveButton = true;
              nominalController.text = nominal.toString();
            });
          },
          child: Container(
            width: 100.w,
            height: 55.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: (nominalController.text == nominal.toString())
                    ? primaryColor
                    : greyColor,
              ),
            ),
            child: Text(
              NumberFormat.currency(
                locale: 'id-ID',
                symbol: 'Rp ',
                decimalDigits: 0,
              ).format(
                nominal,
              ),
              style: font.copyWith(
                fontSize: 14.sp,
                color: (nominalController.text == nominal.toString())
                    ? primaryColor
                    : blackColor,
              ),
            ),
          ),
        );
      }

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Form(
              key: _formKey,
              child: CustomTextFormField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                hintText: 'masukan nominal Top Up',
                prefixIcon: Icon(
                  Icons.money,
                  size: 24.w,
                  color:
                      (nominalController.text.isEmpty) ? greyColor : blackColor,
                ),
                onChanged: (value) {
                  if (nominalController.text.isEmpty) {
                    isActiveButton = false;
                  } else {
                    isActiveButton = true;
                  }
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nominal harus diisi';
                  } else if (int.parse(value) < 10000) {
                    return 'Minimum top up Rp 10.000';
                  } else if (int.parse(value) > 1000000) {
                    return 'Maksimum top up Rp 1000.000';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),
          //NOMINAL 1
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nominal(10000),
                SizedBox(width: 8.w),
                nominal(20000),
                SizedBox(width: 8.w),
                nominal(50000),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          //NOMINAL 2
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nominal(100000),
                SizedBox(width: 8.w),
                nominal(250000),
                SizedBox(width: 8.w),
                nominal(500000),
              ],
            ),
          ),
        ],
      );
    }

    Widget buttonTopUp() {
      return CustomButton(
        backgroundColor: (isActiveButton) ? primaryColor : greyColor,
        title: 'Top Up',
        onTap: (isActiveButton)
            ? () {
                if (_formKey.currentState!.validate()) {
                  showDialogTopUp(
                    nominal: nominalController.text,
                    type: 'topup',
                  );
                }
              }
            : null,
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              cardBalance(),
              title(),
              topUp(),
              SizedBox(height: 52.h),
              buttonTopUp(),
              SizedBox(height: 52.h),
            ],
          ),
        ),
      ),
    );
  }
}
