import 'package:flutter/material.dart';
import 'package:food_order_app/models/chipviewcontrol_item_model.dart';

// ignore: must_be_immutable
class ChipcontrolItemWidget extends StatelessWidget {
  ChipcontrolItemWidget(this.chipviewcontrolItemModelObj,
      {super.key, this.onSelectedChipView});

  ChipviewcontrolItemModel chipviewcontrolItemModelObj;
  Function(bool)? onSelectedChipView;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(canvasColor: Colors.transparent),
        child: RawChip(
          padding:
              const EdgeInsets.only(left: 16, top: 4, bottom: 4, right: 16),
          showCheckmark: false,
          labelPadding: EdgeInsets.zero,
          label: Text(
            chipviewcontrolItemModelObj.controlchip!,
            style: TextStyle(
                color: (chipviewcontrolItemModelObj.isSelected ?? false)
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          selected: (chipviewcontrolItemModelObj.isSelected ?? false),
          backgroundColor: Colors.transparent,
          selectedColor: const Color(0xff1cae81),
          shape: (chipviewcontrolItemModelObj.isSelected ?? false)
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                )
              : RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16)),
          onSelected: (value) {
            onSelectedChipView?.call(value);
          },
        ));
  }
}
