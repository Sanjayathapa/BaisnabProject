
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KhaltiiPayment extends StatefulWidget {
  final double recipePrice;
  final String recipeTitle;
  final String recipeId;

  KhaltiiPayment(
      {Key? key,
      required this.recipePrice,
      required this.recipeTitle,
      required this.recipeId})
      : super(key: key);

  @override
  _KhaltiiPaymentState createState() => _KhaltiiPaymentState();
}

class _KhaltiiPaymentState extends State<KhaltiiPayment> {
  String referenceId = "";

  @override
  void initState() {
    super.initState();
    Khalti.init(publicKey: 'test_public_key_ce2f2ab40248417dbe23b8f447466984');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handlePaymentAndDelete(BuildContext context) async {
    await payWithKhaltiInApp();

    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Text(
                        "Payment Confirmation Page",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/khalti.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please confirm your payment option',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      ' 1. if you want to pay cash on delivery you can go back to the home screen .',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'OR',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2. you can pay money through the following button',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ), SizedBox(height: 31),
                    // Row(
                    //   children: [
                       
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(167, 40),
                            backgroundColor: Color.fromARGB(255, 173, 62, 252),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            _handlePaymentAndDelete(context);
                          },
                          child: Text(
                            "Pay with Khalti",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // SizedBox(width: 21),
                    //       ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         fixedSize: const Size(167, 40),
                    //         backgroundColor: Color.fromARGB(255, 226, 2, 2),
                    //         foregroundColor: Colors.white,
                    //       ),
                    //       onPressed: () {
                    //         _deleteItem(context, widget.recipeTitle);
                    //       },
                    //       child: Text(
                    //         "Cancel Order",
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(height: 20),
                    //   ],
                    // )
                  ],
                ),
                SizedBox(height: 21),
                Center(
                    child: Text(
                  "Payment Amount: ${widget.recipePrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Text(
                  'RecipeTitle: ${widget.recipeTitle}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: (widget.recipePrice * 100).toInt(),
        productIdentity: widget.recipeId,
        productName: widget.recipeTitle,
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.connectIPS,
        PaymentPreference.eBanking,
        PaymentPreference.sct,
        PaymentPreference.mobileBanking,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    setState(() {
      referenceId = success.idx;
    });

   
   
    Navigator.pop(context);

  
    Fluttertoast.showToast(
      msg: 'Payment Successful!',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void onFailure(PaymentFailureModel failure) {
    print('Payment Failure: ${failure.message}');
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
