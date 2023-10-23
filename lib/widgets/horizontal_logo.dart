part of 'widgets.dart';

class HorizontalLogo extends StatelessWidget {
  final double? imageSize;
  final double? fontSize;
  final double? space;
  const HorizontalLogo({
    super.key,
    this.fontSize,
    this.imageSize,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Logo.png',
          width: imageSize ?? 32.w,
        ),
        SizedBox(width: space ?? 16.w),
        Text(
          'SIMS PPOB',
          style: blackTextStyle.copyWith(
            fontSize: fontSize ?? 20.sp,
            fontWeight: bold,
          ),
        )
      ],
    );
  }
}
