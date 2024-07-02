import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_stuti/new_home/model/product_response.dart';
import 'package:test_stuti/utils/custom_text_label_widget.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem(
      {super.key,
      required this.product,
      required this.onTap,
      required this.isSelected});

  final Product? product;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        side: const BorderSide(color: Colors.black),
      ),
      child: ListTile(
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextLabelWidget(
              textAlign: TextAlign.left,
              label: "Name: ${product?.title ?? ""}",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            CustomTextLabelWidget(
              textAlign: TextAlign.left,
              label: 'Description:${product?.description ?? ''}',
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextLabelWidget(
              textAlign: TextAlign.left,
              label: "Category: ${product?.category}",
            ),
            CustomTextLabelWidget(
              textAlign: TextAlign.left,
              label: 'Price: ${product?.price ?? ''}',
            ),
          ],
        ),
        trailing: Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.lightBlue),
            child: Icon(
              !isSelected
                  ? Icons.add_shopping_cart_rounded
                  : Icons.arrow_circle_right,
              size: 16,
            )),
      ),
    );
  }
}
