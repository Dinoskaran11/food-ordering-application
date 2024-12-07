import 'package:flutter/material.dart';
import 'package:food_order_app/models/CategoriesModel';
import 'package:food_order_app/models/chipviewcontrol_item_model.dart';
import 'package:food_order_app/models/itemlist_model.dart';
import 'package:food_order_app/viewmodels/category_viewmodel.dart';
import 'package:food_order_app/viewmodels/items_viewmodel.dart';
import 'package:food_order_app/viewmodels/menu_viewmodel.dart';
import 'package:food_order_app/viewmodels/modifier_viewmodel.dart';
import 'package:food_order_app/views/chipcontrol_item_widget.dart';
import 'package:food_order_app/views/itemlist_widget.dart';
import 'package:provider/provider.dart';

class PricingInitTabScreen extends StatefulWidget {
  const PricingInitTabScreen({super.key});

  @override
  State<PricingInitTabScreen> createState() => _PricingInitTabScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuViewmodel(),
      child: const PricingInitTabScreen(),
    );
  }
}

class _PricingInitTabScreenState extends State<PricingInitTabScreen> {
  String selectedMenu = "LUNCH MENU";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      final modifierviewModel =
          Provider.of<ModifierViewmodel>(context, listen: false);
      // ignore: use_build_context_synchronously
      final categoryViewmodel =
          Provider.of<CategoryViewmodel>(context, listen: false);
      // ignore: use_build_context_synchronously
      final itemsViewModel =
          Provider.of<ItemsViewmodel>(context, listen: false);
      modifierviewModel.loadModifier();
      itemsViewModel.loadItems();

      // ignore: use_build_context_synchronously
      categoryViewmodel.loadCategory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  _buildMenuControls(context),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildCategoriesSection(
                    context,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildItemList(context),
                  //SizedBox(height: 62,),
                  //_buildBasket(context)
                ],
              ),
            ),
          )),
          _buildBasket(context)
        ],
      ),
    );
  }

  Widget _buildMenuControls(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //dropdown menu
                DropdownButtonHideUnderline(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    value: selectedMenu,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: ["LUNCH MENU", "BREAKFAST MENU"]
                        .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 14),
                            )))
                        .toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedMenu = newValue;
                        });
                      }
                    },
                  ),
                )),

                //search
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 374,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Consumer<CategoryViewmodel>(
                  builder: (context, viewmodel, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 8,
                    spacing: 8,
                    children: List<Widget>.generate(viewmodel.categories.length,
                        (index) {
                      final categories = viewmodel.categories[index];
                      bool isSelected =
                          viewmodel.selectedIndices.contains(index);
                      ChipviewcontrolItemModel model = ChipviewcontrolItemModel(
                          controlchip: categories.title?.en ?? "No title",
                          isSelected: isSelected);
                      return ChipcontrolItemWidget(
                        model,
                        onSelectedChipView: (value) {
                          viewmodel.onSelectedChipView(context, index, value);
                        },
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CategoryViewmodel>(
                    builder: (context, categoryviewmodel, child) {
                  final menuentityId = categoryviewmodel.selectedMenuEntitiyId;
                  final selectedcategory = menuentityId != null
                      ? categoryviewmodel.categories.firstWhere(
                          (category) => category.menuEntities
                              .any((entity) => entity.id == menuentityId),
                          orElse: () => Categories(
                              id: "",
                              menuCategoryId: '',
                              menuId: '',
                              storeId: '',
                              title: null,
                              subTitle: null,
                              menuEntities: [],
                              createdDate: null,
                              modifiedDate: null,
                              createdBy: '',
                              modifiedBy: ''))
                      : null;

                  return Text(
                    selectedcategory?.title?.en ?? "No category",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Consumer2<ItemsViewmodel, ModifierViewmodel>(builder:
                    (context, itemsviewmodel, modifierViewmodel, child) {
                  final filteredItems = itemsviewmodel.items;
                  final modifierCounts = itemsviewmodel.countModifiers();
                  if (filteredItems.isEmpty) {
                    return const Center(
                      child: Text("No items available for this category"),
                    );
                  }

                  return ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final model = filteredItems[index];
                        final modifierCount = modifierCounts[model.id] ?? 0;

                        return ItemlistWidget(
                          ItemlistModel(
                              itemtitle: model.title.en,
                              itemsubtitle: model.description.en,
                              price: model.priceInfo.price.pickupPrice),
                          modiferCount: modifierCount,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[200],
                          ),
                        );
                      },
                      itemCount: filteredItems.length);
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBasket(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: 48,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1cae81),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Basket - 0 items - \$0.00",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 48,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xff153E8A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "view basket",
                    style: TextStyle(color: Color(0xff1cae81)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
