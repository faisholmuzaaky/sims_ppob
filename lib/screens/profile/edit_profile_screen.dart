// ignore_for_file: use_build_context_synchronously

part of screen;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();
  bool isEditing = false;
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      AuthProvider authProvider = context.read<AuthProvider>();

      namaDepanController.text = authProvider.user.firstName!;
      namaBelakangController.text = authProvider.user.lastName!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    showDialogUpdate({
      required String pesan,
    }) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 300.h,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
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
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      'Gagal update profile',
                      style: blackTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      pesan,
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Kembali',
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
          'Edit Profile',
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

    Widget form() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                onChanged: (value) {
                  if (value != authProvider.user.firstName) {
                    isEditing = true;
                  } else {
                    isEditing = false;
                  }
                  setState(() {});
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
                onChanged: (value) {
                  if (value != authProvider.user.firstName) {
                    isEditing = true;
                  } else {
                    isEditing = false;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget button() {
      if (isLoading) {
        return LoadingButton(backgroundColor: primaryColor, title: 'Loading');
      } else {
        return CustomButton(
          backgroundColor: isEditing ? primaryColor : greyColor,
          title: 'Simpan',
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = !isLoading;
              });
              final user = authProvider.user.copyWith(
                firstName: namaDepanController.text,
                lastName: namaBelakangController.text,
              );
              final result = await authProvider.update(user: user);
              if (result is bool && result) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationScreen(index: 3),
                  ),
                  (route) => true,
                );
              } else {
                showDialogUpdate(pesan: result);
              }
              setState(() {
                isLoading = !isLoading;
              });
            }
          },
        );
      }
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.h),
              form(),
              SizedBox(height: 32.h),
              button(),
            ],
          ),
        ),
      ),
    );
  }
}
