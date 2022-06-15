import 'package:energyone_station/views/stations/widget/rating.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/dimension.dart';
import '../../../model/response/review_model.dart';
import '../../menu/widget/image.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  final bool hasDivider;
  ReviewWidget({required this.review, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    print('-------------${review.toJson()}');
    return Column(children: [
      Row(children: [
        ClipOval(
          child: CustomImage(
            image: '/${review.customer?.image ?? ''}',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                '${review.customer?.fName} ${review.customer?.lName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.FONT_SIZE_SMALL),
              ),
              RatingBar(
                  rating: review.rating!.toDouble(), ratingCount: 0, size: 15),
              Text('${review.comment}',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      color: Theme.of(context).disabledColor)),
            ])),
      ]),
      hasDivider
          ? Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Divider(color: Theme.of(context).disabledColor),
            )
          : const SizedBox(),
    ]);
  }
}
