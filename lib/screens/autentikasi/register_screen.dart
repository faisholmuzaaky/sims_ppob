part of screen;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  bool isPassword = false;
  bool isCPassword = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();
    showDialogRegister({
      required String type,
      String? pesan,
    }) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 280.h,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
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
                    (type == 'berhasil') ? 'Berhasil' : 'Gagal',
                    style: blackTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      (type == 'berhasil') ? 'Registrasi berhasil' : pesan!,
                      style: blackTextStyle,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      if (type == 'berhasil') {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      (type == 'berhasil') ? 'Login' : 'Kembali',
                      style: primaryTextStyle.copyWith(
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

    Widget logo() {
      return const HorizontalLogo();
    }

    Widget title() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 52.h),
        child: Text(
          'Lengkapi data untuk\nmembuat akun',
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
                controller: namaDepanController,
                hintText: 'nama depan',
                prefixIcon: const Icon(
                  Icons.person_outline,
                ),
                validator: (value) {
                  return Validation.field(
                    value: value,
                    namaField: 'Nama depan',
                  );
                },
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                controller: namaBelakangController,
                hintText: 'nama belakang',
                prefixIcon: const Icon(
                  Icons.person_outline,
                ),
                validator: (value) {
                  return Validation.field(
                    value: value,
                    namaField: 'Nama belakang',
                  );
                },
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                controller: passwordController,
                isPassword: !isPassword,
                hintText: 'buat password',
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
              SizedBox(height: 32.h),
              CustomTextFormField(
                controller: cpasswordController,
                isPassword: !isCPassword,
                hintText: 'konfirmasi password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isCPassword = !isCPassword;
                    });
                  },
                  child: isCPassword
                      ? const Icon(
                          Icons.visibility_outlined,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                        ),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Password tidak sama';
                  } else {
                    return Validation.password(
                      password: value!,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget buttonRegistrasi() {
      if (isLoading) {
        return LoadingButton(backgroundColor: primaryColor, title: 'Loading');
      } else {
        return CustomButton(
          backgroundColor: primaryColor,
          title: 'Registrasi',
          onTap: () async {
            setState(() {
              isLoading = !isLoading;
            });
            if (_formKey.currentState!.validate()) {
              final user = UserModel(
                email: emailController.text,
                firstName: namaDepanController.text,
                lastName: namaBelakangController.text,
              );
              var result = await authProvider.register(
                  user: user, password: passwordController.text);
              if (result is bool && result) {
                showDialogRegister(
                  type: 'berhasil',
                );
              } else {
                showDialogRegister(
                  type: 'gagal',
                  pesan: result,
                );
              }
            }
            setState(() {
              isLoading = !isLoading;
            });
          },
        );
      }
    }

    Widget footer() {
      return RichText(
        text: TextSpan(
          text: 'sudah punya akun? login ',
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
                  Navigator.pop(context);
                },
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 52.h),
              logo(),
              title(),
              form(),
              SizedBox(height: 52.h),
              buttonRegistrasi(),
              SizedBox(height: 36.h),
              footer(),
              SizedBox(height: 52.h),
            ],
          ),
        ),
      ),
    );
  }
}
