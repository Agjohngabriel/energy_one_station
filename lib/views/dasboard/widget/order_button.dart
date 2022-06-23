import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/order_controller.dart';
import '../../../helpers/dimension.dart';

class OrderButton extends StatelessWidget {
  final String title;
  final int index;
  final OrderController orderController;
  final bool fromHistory;
  OrderButton(
      {required this.title,
      required this.index,
      required this.orderController,
      required this.fromHistory});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex;
    int _length = 0;
    int _titleLength = 0;
    if (fromHistory) {
      _selectedIndex = orderController.historyIndex;
      _titleLength = orderController.statusList.length;
      _length = orderController.countHistoryList(index);
    } else {
      _selectedIndex = orderController.orderIndex;
      _titleLength = orderController.runningOrders!.length;
      _length = orderController.runningOrders![index].orderList.length;
    }
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => fromHistory
          ? orderController.setHistoryIndex(index)
          : orderController.setOrderIndex(index),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: isSelected ? AppTheme.blue : Theme.of(context).cardColor,
          ),
          alignment: Alignment.center,
          child: Text(
            '$title ($_length)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.mulish(
              fontSize: Dimensions.FONT_SIZE_SMALL,
              color: isSelected ? AppTheme.white : AppTheme.black,
            ),
          ),
        ),
        (index != _titleLength - 1 &&
                index != _selectedIndex &&
                index != _selectedIndex - 1)
            ? Container(
                height: 15,
                width: 1,
                color: Theme.of(context).disabledColor,
              )
            : const SizedBox(),
      ]),
    );
  }
}
