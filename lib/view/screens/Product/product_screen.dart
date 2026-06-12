import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llb_task/controller/product_controller.dart';
import 'package:llb_task/utils/app_constant.dart';
import 'package:llb_task/view/base/custom_loader.dart';
import 'package:llb_task/view/screens/Product/widget/all_product_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final controller = Get.find<ProductController>();

    controller.getProductList(reload: true);

    _scrollController.addListener(() {
      if (controller.searchQuery.isNotEmpty) return;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.getProductList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Products'),
      ),

      body: GetBuilder<ProductController>(
        builder: (productController) {
          if (productController.productList.isEmpty &&
              productController.isLoading) {
            return const CustomLoader();
          }

          if (productController.productList.isEmpty) {
            return const Center(child: Text("No Product Available"));
          }
          final isSearching = productController.searchQuery.trim().isNotEmpty;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            productController.searchProduct(value);
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search),
                            // suffixIcon: _searchController.text.isNotEmpty
                            //     ? IconButton(
                            //         onPressed: () {
                            //           _searchController.clear();
                            //           productController.searchProduct('');
                            //         },
                            //         icon: const Icon(Icons.clear),
                            //       )
                            //     : null,
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {});

                                      productController.searchProduct('');
                                    },
                                    icon: const Icon(Icons.clear),
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: productController.selectedCategory,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.red,
                          ),
                          items: productController.categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              productController.changeCategory(value);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max Price: ${AppConstant.currency}${productController.maxPrice.toInt()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      activeColor: Colors.red,
                      value: productController.maxPrice,
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      label: productController.maxPrice.toInt().toString(),
                      onChanged: (value) {
                        productController.changePrice(value);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: productController.filteredProductList.isEmpty
                    ? const Center(child: Text("No Product Found"))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount:
                            productController.filteredProductList.length +
                            (!isSearching && productController.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (!isSearching &&
                              index ==
                                  productController
                                      .filteredProductList
                                      .length) {
                            return const Padding(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              child: Center(child: CustomLoader()),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6, top: 15),
                            child: AllProductWidget(
                              products:
                                  productController.filteredProductList[index],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
