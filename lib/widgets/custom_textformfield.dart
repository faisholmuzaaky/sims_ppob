part of 'widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      obscuringCharacter: '●',
      style: blackTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: greyTextStyle.copyWith(fontSize: 14.sp),
        prefixIcon: prefixIcon,
        prefixIconColor: MaterialStateColor.resolveWith(
          (states) =>
              states.contains(MaterialState.focused) ? blackColor : greyColor,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: MaterialStateColor.resolveWith(
          (states) =>
              states.contains(MaterialState.focused) ? blackColor : greyColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blackColor),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
