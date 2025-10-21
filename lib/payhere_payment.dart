import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class PayHerePaymentScreen extends StatefulWidget {
  const PayHerePaymentScreen({Key? key}) : super(key: key);

  @override
  State<PayHerePaymentScreen> createState() => _PayHerePaymentScreenState();
}

class _PayHerePaymentScreenState extends State<PayHerePaymentScreen> {
  final String merchantId = "1232553"; // Your Merchant ID
  final String merchantSecret = "NDU3OTM3ODc0MzgxNjYwNTE3MzI4OTkzMjMyNjkyNjUzOTE2OTc=";
  final bool sandboxMode = true;

  void startPayment() async {
    var paymentObject = {
      "sandbox": sandboxMode,
      "merchant_id": merchantId,
      "merchant_secret": merchantSecret,
      "notify_url": "https://sandbox.payhere.lk/merchant/v1/pay",
      "order_id": "Order001",
      "items": "Test Item",
      "amount": 30.00,
      "currency": "LKR",
      "first_name": "Niroshan",
      "last_name": "Pushparaj",
      "email": "niro@example.com",
      "phone": "0771234567",
      "address": "Colombo",
      "city": "Colombo",
      "country": "Sri Lanka",
      // "delivery_address": "Colombo",
      // "delivery_city": "Colombo",
      // "delivery_country": "Sri Lanka",
      // "custom_1": "",
      // "custom_2": ""
    };

    try {
      PayHere.startPayment(paymentObject, (paymentId) {
        print("Payment Success. PaymentID: $paymentId");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Payment successful! ID: $paymentId")),
        );
      }, (error) {
        print("Payment Failed. Error: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Payment failed: $error")),
        );
      }, () {
        print("Payment Dismissed");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ Payment dismissed")),
        );
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PayHere Demo")),
      body: Center(
        child: ElevatedButton(
          onPressed: startPayment,
          child: const Text("Pay LKR 30"),
        ),
      ),
    );
  }
}
