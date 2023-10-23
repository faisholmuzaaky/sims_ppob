// ignore_for_file: use_build_context_synchronously

part of screen;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(
      duration,
      () async {
        final isLogin = await context.read<AuthProvider>().cekLogin();

        if (isLogin) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationScreen(),
              ),
              (route) => true);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => true);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo.png'),
              SizedBox(height: 24.h),
              Text(
                'SIMS PPOB',
                style: blackTextStyle.copyWith(
                  fontSize: 24.sp,
                  fontWeight: bold,
                ),
              ),
              SizedBox(height: 52.h),
              Text(
                'Faishol Muzaky Dwi Putra',
                style: blackTextStyle.copyWith(fontSize: 12.sp),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
