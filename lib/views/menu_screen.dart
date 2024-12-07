import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_order_app/views/pricing_init_tab_screen.dart';

import 'action_bottom_sheet.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showActionBottomSheet(context);
    });
  }

  void _showActionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return const ActionBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _banner(context),
                Expanded(
                    child: Container(
                  child:
                      TabBarView(controller: _tabController, children: const [
                    PricingInitTabScreen(),
                    PricingInitTabScreen(),
                    PricingInitTabScreen(),
                  ]),
                ))
              ],
            )),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 210,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cover-container.png',
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                    )
                  ],
                ),
              )),
          Container(
            width: 208,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: const Color(0xFFe7e7e7), width: 0.92)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TabBar(
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const BoxDecoration(color: Color(0xffebeff8)),
                  dividerHeight: 0.0,
                  tabs: [
                    Tab(
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/images/deliver.svg',
                        height: 22,
                        width: 22,
                      ),
                    ),
                    Tab(
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/images/take_away.svg',
                        height: 22,
                        width: 22,
                      ),
                    ),
                    Tab(
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/images/receive.svg',
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
