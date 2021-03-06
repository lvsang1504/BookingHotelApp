import 'package:book_hotel/shared_code/model/review_model.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    this.review,
  }) : super(key: key);

  final Reviews? review;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(
            radius: 100,
            backgroundImage:
                NetworkImage("https://airj18.skqist225.xyz" + review!.customerAvatar!),
          ),
        ),
        title: Text(review!.customerName!),
        subtitle: Text(review!.comment!),
        trailing: Text(review!.rating!.checkin.toString()),
      ),
    );
  }
}
