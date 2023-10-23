part of screen;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();

  File? file;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    emailController.text = authProvider.user.email!;
    namaDepanController.text = authProvider.user.firstName!;
    namaBelakangController.text = authProvider.user.lastName!;

    showDialogImage({
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
                      'Gagal update foto profile',
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
          'Akun',
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

    Widget imageProfile() {
      return Column(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyColor),
              image: (file == null)
                  ? const DecorationImage(
                      image: AssetImage('assets/Profile Photo-1.png'),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: FileImage(file!),
                      fit: BoxFit.cover,
                    ),
            ),
            child: GestureDetector(
              onTap: () async {
                final image = await Functions().getImage();
                file = File(image);
                final result = await authProvider.image(
                  image: file!,
                );
                if (result is bool && result) {
                  setState(() {});
                } else {
                  showDialogImage(pesan: result);
                }
              },
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: greyColor),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.edit,
                  size: 18.w,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget form() {
      buildField(IconData icon, String title) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(6.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 8.w),
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            buildField(
              Icons.alternate_email_rounded,
              authProvider.user.email!,
            ),
            SizedBox(height: 20.h),
            buildField(
              Icons.person_outline,
              authProvider.user.firstName!,
            ),
            SizedBox(height: 20.h),
            buildField(
              Icons.person_outline,
              authProvider.user.lastName!,
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Column(
        children: [
          SizedBox(height: 32.h),
          CustomButton(
            backgroundColor: primaryColor,
            title: 'Edit Profile',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                )),
          ),
          SizedBox(height: 32.h),
          const CustomButton(
            backgroundColor: Colors.white,
            title: 'Log Out',
            isOutlineButton: true,
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              imageProfile(),
              SizedBox(height: 32.h),
              form(),
              button(),
            ],
          ),
        ),
      ),
    );
  }
}
