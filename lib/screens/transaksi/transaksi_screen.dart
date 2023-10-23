part of screen;

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  int? offet = 0;
  int? limit = 3;

  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    BalanceProvider balanceProvider = context.read<BalanceProvider>();
    TransaksiProvider transaksiProvider = context.read<TransaksiProvider>();
    AuthProvider authProvider = context.read<AuthProvider>();

    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Transaksi',
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
            ),
          ],
        ),
      );
    }

    Widget transaksi() {
      Widget itemTransaksi(TransaksiModel transaksi) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        (transaksi.transactionType == 'PAYMENT')
                            ? Icons.remove
                            : Icons.add,
                        color: (transaksi.transactionType == 'PAYMENT')
                            ? primaryColor
                            : greenColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        NumberFormat.currency(
                          locale: 'id-ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(
                          transaksi.totalAmount,
                        ),
                        style: font.copyWith(
                          fontSize: 20.sp,
                          fontWeight: semiBold,
                          color: (transaksi.transactionType == 'PAYMENT')
                              ? primaryColor
                              : greenColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    DateFormat('dd MMMM y HH:mm', 'id-ID')
                        .format(DateTime.parse(transaksi.createdOn!)),
                    style: greyTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              Text(
                (transaksi.transactionType == 'PAYMENT')
                    ? 'Bayar ${transaksi.description}'
                    : transaksi.description!,
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: medium,
                ),
              )
            ],
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Transaksi',
              style: blackTextStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: semiBold,
              ),
            ),
          ),
          FutureBuilder(
            future: transaksiProvider.history(
              token: authProvider.token,
              offet: offet,
              limit: limit,
            ),
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
                if (snapshot.data is List<TransaksiModel>) {
                  return Column(
                    children: transaksiProvider.listTransaksi
                        .map(
                          (item) => Padding(
                            padding: EdgeInsets.only(top: 24.h),
                            child: itemTransaksi(item),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      );
    }

    Widget buttonShowMore() {
      return CustomButton(
        backgroundColor: Colors.white,
        title: 'Show More',
        isOutlineButton: true,
        onTap: () {
          transaksiProvider.history(token: authProvider.token);
          setState(() {
            offet = null;
            limit = null;
            isShowMore = !isShowMore;
          });
        },
      );
    }

    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardBalance(),
            SizedBox(
              height: 52.h,
            ),
            transaksi(),
            SizedBox(
              height: 24.h,
            ),
            if (isShowMore)
              Column(
                children: [
                  buttonShowMore(),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
