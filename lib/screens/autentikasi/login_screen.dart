// ignore_for_file: use_build_context_synchronously

part of screen;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    Widget logo() {
      return const HorizontalLogo();
    }

    Widget title() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 52.h),
        child: Text(
          'Masuk atau buat akun\nuntuk memulai',
          style: blackTextStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget form() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'masukan email anda',
                prefixIcon: const Icon(
                  Icons.alternate_email_rounded,
                ),
                validator: (value) {
                  return Validation.email(value);
                },
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                controller: passwordController,
                isPassword: !isPassword,
                hintText: 'masukan password anda',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  child: isPassword
                      ? const Icon(
                          Icons.visibility_outlined,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                        ),
                ),
                validator: (value) {
                  return Validation.password(password: value!);
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget buttonLogin() {
      if (isLoading) {
        return LoadingButton(backgroundColor: primaryColor, title: 'Loading');
      } else {
        return CustomButton(
            backgroundColor: primaryColor,
            title: 'Masuk',
            onTap: () async {
              setState(() {
                isLoading = !isLoading;
              });
              if (_formKey.currentState!.validate()) {
                var result = await authProvider.login(
                  email: emailController.text,
                  password: passwordController.text,
                );
                if (result is UserModel) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationScreen(),
                    ),
                    (route) => true,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      showCloseIcon: true,
                      elevation: 0,
                      backgroundColor: thirdColor.withOpacity(0.16),
                      closeIconColor: secondaryColor,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        result,
                        style: font.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  );
                }
              }
              setState(() {
                isLoading = !isLoading;
              });
            });
      }
    }

    Widget footer() {
      return RichText(
        text: TextSpan(
          text: 'belum punya akun? registrasi ',
          style: greyTextStyle.copyWith(fontSize: 14.sp, fontWeight: semiBold),
          children: [
            TextSpan(
              text: 'di sini',
              style: primaryTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: semiBold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //LOGO
                logo(),
                //TITLE
                title(),
                //FORM LOGIN
                form(),
                SizedBox(height: 52.h),
                //BUTON LOGIN
                buttonLogin(),
                //FOOTER
                SizedBox(height: 36.h),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
