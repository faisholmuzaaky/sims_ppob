import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sims_ppob/provider/auth_provider.dart';
import 'package:sims_ppob/provider/balance_provider.dart';
import 'package:sims_ppob/provider/banner_provider.dart';
import 'package:sims_ppob/provider/layanan_provider.dart';
import 'package:sims_ppob/provider/transaksi_provider.dart';
import 'package:sims_ppob/screens/screen.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BalanceProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LayananProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BannerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TransaksiProvider(),
          ),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );
  }
}
