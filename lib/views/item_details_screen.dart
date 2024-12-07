import 'package:flutter/material.dart';
import 'package:food_order_app/views/custom_image_view.dart';
import 'package:food_order_app/views/tab_bar_controller.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String? itemTitle;
  final String? itemSubTitle;
  final int? itemPrice;
  const ItemDetailsScreen(
      {super.key,
      required this.itemTitle,
      required this.itemSubTitle,
      required this.itemPrice});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int count = 1;
  late int totalPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = widget.itemPrice ?? 0;
  }

  void increaseCount() {
    setState(() {
      count++;
      totalPrice = widget.itemPrice! * count;
    });
  }

  void decreaseCount() {
    if (count > 1) {
      setState(() {
        count--;
        totalPrice = widget.itemPrice! * count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close,
                            size: 28, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const CustomImageView(
                        imagePath: "assets/images/item.png",
                        height: 200,
                        width: double.maxFinite,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.itemTitle ?? "No Title",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$${widget.itemPrice ?? 0}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff1cae81),
                            size: 28,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xff1cae81),
                                size: 20,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.itemSubTitle ?? "No Description ",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const TabBarController(),
                      const SizedBox(height: 32),
                      const Text(
                        "Add Comments (Optional)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Write here..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: const Color(0xff153E8A0D),
                    height: 56,
                    width: 144,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Color(0xff1cae81),
                          ),
                          onPressed: decreaseCount,
                        ),
                        Text(
                          "$count",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xff1cae81),
                          ),
                          onPressed: increaseCount,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1cae81),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Add to Cart \$${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
