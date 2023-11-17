import 'package:flutter/material.dart';
import 'package:rempah_apps/widgets/data.dart';

class RempahDetail extends StatelessWidget {
  const RempahDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            product.name,
            maxLines: 2,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          Hero(
            tag: product.image,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 255,
            color: Colors.deepOrangeAccent,
            padding: const EdgeInsets.all(20),
            child: Text(
              product.specialist,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
            ),
          ),
        ],
      ),
    );
  }
}
