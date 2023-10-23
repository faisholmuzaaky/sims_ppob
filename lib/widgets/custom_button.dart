part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final double? height;
  final String title;
  final bool isOutlineButton;
  final Function()? onTap;
  const CustomButton({
    super.key,
    required this.backgroundColor,
    this.height = 48,
    required this.title,
    this.isOutlineButton = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isOutlineButton ? primaryColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(6),
          color: backgroundColor,
        ),
        child: Text(
          title,
          style: font.copyWith(
            color: isOutlineButton ? primaryColor : Colors.white,
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }
}
