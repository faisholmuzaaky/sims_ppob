part of 'widgets.dart';

class LoadingButton extends StatelessWidget {
  final Color backgroundColor;
  final double? height;
  final String title;
  final bool isOutlineButton;
  const LoadingButton({
    super.key,
    required this.backgroundColor,
    this.height = 48,
    required this.title,
    this.isOutlineButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            margin: EdgeInsets.only(right: 12.w),
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
          Text(
            title,
            style: font.copyWith(
              color: isOutlineButton ? primaryColor : Colors.white,
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }
}
