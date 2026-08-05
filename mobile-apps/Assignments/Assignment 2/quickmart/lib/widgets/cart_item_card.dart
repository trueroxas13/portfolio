import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';

class CartItemCard extends ConsumerStatefulWidget {
  final Product product;
  final CartItem cartItem;
  const CartItemCard({super.key, required this.product, required this.cartItem});

  @override
  ConsumerState<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends ConsumerState<CartItemCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
          color: Colors.white,
          semanticContainer: true,
          elevation: 5,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: double.infinity,
                child: Image.asset('assets/images/${widget.product.imageName}', fit: BoxFit.cover,),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: SizedBox(
                      width:175,
                      height: 65,
                      child: Text(widget.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: SizedBox(
                      width: 175,
                      child: Text('QR ${widget.cartItem.unitPrice} \nP E R   U N I T', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: const Color.fromARGB(255, 145, 145, 145)))),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            widget.cartItem.quantity == 1 ? {} :
                            ref.read(cartNotifierProvider.notifier).decreaseQuantity(widget.cartItem.productId);
                          });
                        }, 
                        icon:widget.cartItem.quantity > 1 ? Icon(Icons.remove, color: Colors.red) : Icon(Icons.remove)
                        ),
                      Text('${widget.cartItem.quantity}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            ref.read(cartNotifierProvider.notifier).increaseQuantity(widget.cartItem.productId);
                          });
                        }, 
                        icon: Icon(Icons.add, color: Colors.green)
                        ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){
                      ref.read(cartNotifierProvider.notifier).removeCartItem(widget.cartItem.productId);
                    },  
                    icon: 
                      Icon(Icons.cancel)
                    ),
                  SizedBox(height: 90,),
                  SizedBox(
                    width: 100,
                    child: Text('QR ${(widget.cartItem.unitPrice * widget.cartItem.quantity).toStringAsFixed(2)}',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 29,
                      ),),
                  ),
                ],
              ),
            ],
          )
        ),
      );
  }
}
