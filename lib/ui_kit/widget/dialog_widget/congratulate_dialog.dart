import 'package:book_hotel/common/define_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CongratulateDialog extends StatelessWidget {
  const CongratulateDialog({
    required this.content,
    required this.onPressed,
    this.textButton = '',
  });

  final VoidCallback onPressed;
  final String content;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black12, // set border color
            width: 1,
          ),
        ),
        child: _dialogContent(context),
      ),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          child: SvgPicture.asset(
            '${PATH_IMAGE}ico_congratulate_dialog.svg',
            width: 80,
            height: 80,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                height: 35,
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    textButton.isEmpty ? 'Agree' : textButton.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      color:Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
