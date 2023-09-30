import 'package:flutter/material.dart';



class AddToCartButton extends StatefulWidget {
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          addedToCart = !addedToCart;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: addedToCart ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: addedToCart
              ? Icon(
            Icons.check,
            color: Colors.white,
          )
              : Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
