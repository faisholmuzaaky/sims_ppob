part of screen;

class PembayaranScreen extends StatelessWidget {
  final LayananModel layanan;
  const PembayaranScreen({super.key, required this.layanan});

  @override
  Widget build(BuildContext context) {
    BalanceProvider balanceProvider = context.read<BalanceProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    showDialogTopUp({
      required num nominal,
      required String type,
    }) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: (type == 'bayar') ? 320.h : 300.h,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  if (type == 'bayar')
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
                    (type == 'bayar')
                        ? 'Bayar ${layanan.serviceName} senilai'
                        : 'Pembayaran ${layanan.serviceName} sebesar',
                    style: blackTextStyle,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    NumberFormat.currency(
                      locale: 'id-ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(
                      nominal,
                    ),
                    style: blackTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                  if (type != 'bayar')
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
                      if (type == 'bayar') {
                        Navigator.pop(context);
                        final result = await balanceProvider.bayar(
                          token: authProvider.token,
                          layanan: layanan,
                        );
                        if (result is bool && result) {
                          showDialogTopUp(
                            nominal: nominal,
                            type: 'berhasil',
                          );
                        } else {
                          showDialogTopUp(
                            nominal: nominal,
                            type: 'gagal',
                          );
                        }
                      } else if (type == 'berhasil' || type == 'gagal') {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      (type == 'bayar')
                          ? 'Ya, lanjutkan Bayar'
                          : 'Kembali ke Beranda',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  if (type == 'bayar') SizedBox(height: 24.h),
                  if (type == 'bayar')
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
          'Pembayaran',
          style: blackTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: semiBold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
              style: blackTextStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    }

    Widget pembayaran() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Text(
              'Pembayaran',
              style: blackTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Row(
              children: [
                Image.network(
                  layanan.serviceIcon!,
                  width: 48.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  layanan.serviceName!,
                  style: blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: semiBold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(6.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
              child: Row(
                children: [
                  Icon(
                    Icons.money,
                    color: blackColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    NumberFormat.currency(
                      locale: 'id-ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(
                      layanan.serviceTarif,
                    ),
                    style: blackTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: semiBold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonPembayaran() {
      return CustomButton(
        backgroundColor: primaryColor,
        title: 'Bayar',
        onTap: () {
          showDialogTopUp(
            nominal: layanan.serviceTarif!,
            type: 'bayar',
          );
        },
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardBalance(),
            SizedBox(height: 32.h),
            pembayaran(),
            SizedBox(height: 52.h),
            buttonPembayaran(),
          ],
        ),
      ),
    );
  }
}
