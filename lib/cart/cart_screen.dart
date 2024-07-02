import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_stuti/new_home/model/product_response.dart';
import 'package:test_stuti/utils/custom_text_label_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (var product in productList) {
      totalPrice += product.price ?? 0;
    }
    return Scaffold(appBar: AppBar(centerTitle: true,title: const CustomTextLabelWidget(label:'Cart'),elevation: 0,),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: CustomTextLabelWidget(
                      textAlign: TextAlign.left,
                      label: productList[index].title ?? '',
                    ),
                    trailing:  CustomTextLabelWidget(
                      textAlign: TextAlign.left,
                      label: productList[index].price.toString() ?? '',
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: productList.length),
          ),
          Padding(
            padding:  EdgeInsets.all(8.w),
            child: CustomTextLabelWidget(style: TextStyle(fontSize: 20.sp),label: 'Total $totalPrice',textAlign: TextAlign.left,),
          )
        ],
      ),
    );
  }
}
