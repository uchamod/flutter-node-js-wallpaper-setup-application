import 'package:flutter/material.dart';
import 'package:flutter_client/util/constants.dart';

class ReusableButton extends StatelessWidget {
  final String lable;
  final bool isLoad;
  const ReusableButton({super.key, required this.lable, required this.isLoad});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: primaryColor,
       
      ),
      child: Center(
        child: isLoad
            ? const CircularProgressIndicator(
                color: Color(0xfff0f0f0),
                strokeWidth: 8,
              )
            : Text(lable,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xfff0f0f0),
                    fontWeight: FontWeight.w600)),
      ),
    );
  }
}
