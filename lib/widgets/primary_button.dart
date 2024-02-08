import 'package:clinicx_patient/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      this.text,
      this.onTap,
      this.child,
      this.textColor = Colors.white,
      this.borderRadius = 8,
      this.color = dBlueColor,
      this.borderColor,
      this.height,
      this.isLoading = false})
      : assert(text != null || child != null);

  final String? text;
  final Widget? child;
  final Function? onTap;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final double borderRadius;
  final double? height;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null && !isLoading) {
          onTap!();
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height ?? 49,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1)
                : null,
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : child ??
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
