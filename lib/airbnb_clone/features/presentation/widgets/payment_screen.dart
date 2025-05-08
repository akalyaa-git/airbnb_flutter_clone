import 'package:airbnb_flutter_clone/airbnb_clone/features/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';

class PaymentScreen extends StatefulWidget {
  final Property property;

  const PaymentScreen({super.key, required this.property});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  String _status = "No transaction yet";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    setState(() {
      _status = "✅ Payment Successful: ${response.paymentId}";
    });

    // Optionally pop back with success result
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context, true);
    });
  }

  void _handleError(PaymentFailureResponse response) {
    setState(() {
      _status = "❌ Payment Failed: ${response.message}";
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _status = "Wallet Selected: ${response.walletName}";
    });
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Test key only
      'amount': (widget.property.price * 100).toInt(), // price in paise
      'name': 'Airbnb Booking',
      'description': widget.property.title,
      'prefill': {
        'contact': '9123456789',
        'email': 'test@example.com',
      },
      'theme': {
        'color': '#3399cc',
      }
    };

    _razorpay.open(options);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Razorpay Web Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Property: ${widget.property.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Amount: \$${widget.property.price}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _openCheckout,
                child: const Text('Proceed to Pay'),
              ),
              const SizedBox(height: 30),
              Text(_status, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
