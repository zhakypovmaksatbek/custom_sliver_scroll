import 'package:custom_sliver/core/data/model/product_model.dart';
import 'package:custom_sliver/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ListGroup extends StatelessWidget {
  const ListGroup({super.key, required this.label, required this.data});

  final String label;
  final List<ProductModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = data[index];
            return ProductCard(product: item);
          },
          itemCount: data.length,
        )
      ],
    );
  }
}
