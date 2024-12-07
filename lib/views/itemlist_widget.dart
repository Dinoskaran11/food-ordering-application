import 'package:flutter/material.dart';
import 'package:food_order_app/models/itemlist_model.dart';
import 'package:food_order_app/views/item_details_screen.dart';

import 'custom_image_view.dart';

// ignore: must_be_immutable
class ItemlistWidget extends StatelessWidget {
  final int modiferCount;
  ItemlistWidget(this.itemlistModelObj,
      {super.key, required this.modiferCount});

  ItemlistModel itemlistModelObj;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(
                    itemTitle: itemlistModelObj.itemtitle,
                    itemSubTitle: itemlistModelObj.itemsubtitle,
                    itemPrice: itemlistModelObj.price)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomImageView(
            imagePath: "assets/images/burger.png",
            height: 48,
            width: 48,
            borderRadius: 8,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemlistModelObj.itemtitle!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  itemlistModelObj.itemsubtitle!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Text(
                        "\$${itemlistModelObj.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xff1cae81)),
                      ),
                      if (modiferCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            height: 24,
                            width: 152,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffffb200),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                    padding: EdgeInsets.zero),
                                child: Text(
                                  "$modiferCount Promotions Available",
                                  style: const TextStyle(color: Colors.black),
                                )),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
