import 'package:flutter/material.dart';
import 'package:rempah_apps/Views/detail_rempah_item.dart';
import 'data.dart';

class ItemRempah extends StatelessWidget {
  const ItemRempah({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RempahDetail(
            product: product,
          );
        }));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.deepOrange,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          width: 150, // Sesuaikan dengan lebar yang diinginkan
          child: Center(
            child: Column(
              children: [
                Hero(
                  tag: product.image,
                  child: SizedBox(
                    width: 150,
                    child: Image.asset(product.image),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Kualitas Rempah - Rempah',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
