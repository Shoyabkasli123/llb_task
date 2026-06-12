import 'package:flutter/material.dart';
import 'package:llb_task/data/model/response/product_model.dart';
import 'package:llb_task/utils/app_constant.dart';
import 'package:llb_task/view/screens/Product/image_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Products product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final price = product.price ?? 0;
    final discount = product.discountPercentage ?? 0;

    final discountedPrice = price - ((price * discount) / 100);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title ?? 'Product'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageSlider(
                images: product.images ?? [],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brand ?? '',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
          
                    const SizedBox(height: 5),
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text('${product.rating}'),
                      ],
                    ),
          
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          '${AppConstant.currency}${discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${AppConstant.currency}$price',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
          
                    const SizedBox(height: 8),
          
                    Text(
                      '${product.discountPercentage}% OFF',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    const Divider(height: 30),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
          
                    const SizedBox(height: 8),
          
                    Text(product.description ?? ''),
          
                    const Divider(height: 30),
                    _productRow('Category', product.category ?? ''),
          
                    _productRow('Stock', '${product.stock}'),
          
                    _productRow('SKU', product.sku ?? ''),
          
                    _productRow('Weight', '${product.weight} kg'),
          
                    _productRow('Availability', product.availabilityStatus ?? ''),
          
                    _productRow('Warranty', product.warrantyInformation ?? ''),
          
                    _productRow('Shipping', product.shippingInformation ?? ''),
          
                    _productRow('Return Policy', product.returnPolicy ?? ''),
          
                    _productRow('Minimum Qty', '${product.minimumOrderQuantity}'),
          
                    const Divider(height: 30),
                    const Text(
                      'Dimensions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
          
                    const SizedBox(height: 10),
          
                    _productRow('Width', '${product.dimensions?.width}'),
          
                    _productRow('Height', '${product.dimensions?.height}'),
          
                    _productRow('Depth', '${product.dimensions?.depth}'),
          
                    const Divider(height: 30),
                    const Text(
                      'Tags',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
          
                    const SizedBox(height: 10),
          
                    Wrap(
                      spacing: 8,
                      children:
                          product.tags
                              ?.map(
                                (tag) => Chip(
                                  backgroundColor: Colors.white,
                                  label: Text(tag),
                                ),
                              )
                              .toList() ??
                          [],
                    ),
          
                    const Divider(height: 30),
                    const Text(
                      'Reviews',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
          
                    const SizedBox(height: 10),
          
                    ...?product.reviews?.map(
                      (review) => Card(
                        color: Colors.white,
          
                        child: ListTile(
                          title: Text(review.reviewerName ?? ''),
                          subtitle: Text(review.comment ?? ''),
                          trailing: Text('${review.rating} ⭐'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SizedBox(),
    );
  }

  Widget _productRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
