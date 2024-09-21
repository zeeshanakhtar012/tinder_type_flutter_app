import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'controller_home.dart';


class PaymentsController extends GetxController {
  static const stripePublishableKey = "pk_test_51P4j2gJnrGXVIoZJBz8M2v2koMjqDCzuJJiAkuVJyZWVi0WGwoDsYwphQPfvjjrxPkADOv5bWnyLqE9rUazAGVxk00khi8ETuz";
  final String apiKey = "sk_test_51P4j2gJnrGXVIoZJys1UVYUjq8K22uNzSTU17xTxxzI76RmvrmPctauDuHgbiZkRyzrK6bNzfBNhDq7PstqeqIyT00Zp02SpWg";

  Rx<bool> paymentLoading = false.obs;
  Map<String, dynamic>? paymentIntent;

  @override
  void onInit() {
    super.onInit();
    Stripe.publishableKey = stripePublishableKey;
    Stripe.instance.applySettings();
  }

  Future<void> makePayment(String amount, String productId, {Function(Map<String, dynamic> infoData)? onSuccess, Function(String error)? onError}) async {
    try {
      paymentLoading(true);
      paymentIntent = await createPaymentIntent(amount, productId);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: "1",
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: "Blaxity",
        ),
      );

      Map<String, dynamic> infoData = {
        "id": "${paymentIntent?["id"] ?? ""}",
        "status": "requires_payment_method",
        "amount": ((paymentIntent?["amount"] ?? -100) / 100),
        "created": paymentIntent?["created"] ?? 0,
        "currency": paymentIntent?["currency"] ?? "",
        "livemode": paymentIntent?["livemode"] ?? false,
        "payment_method": "",
      };

      await displayPaymentSheet(onSuccess, onError, infoData);
    } catch (err) {
      print(err);
      if (onError != null) {
        onError(err.toString());
      }
    } finally {
      paymentLoading(false);
    }
  }

  Future<void> displayPaymentSheet(Function(Map<String, dynamic> infoData)? onSuccess, Function(String error)? onError, Map<String, dynamic> infoData) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // Retrieve the payment intent to get updated information, including the payment method ID
        final paymentIntentId = infoData["id"];
        final paymentIntentDetails = await retrievePaymentIntent(paymentIntentId);

        infoData["status"] = paymentIntentDetails['status'];
        infoData["payment_method"] = paymentIntentDetails['payment_method'];

        paymentIntent = null;
        if (onSuccess != null) {
          onSuccess(infoData);
        }
      });
    } catch (e) {
      print('$e');
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String productId) async {
    try {
      final String corsUrl = "https://corsproxy.io/?";
      final String baseUrl = '${corsUrl}https://api.stripe.com/v1/payment_intents';

      var headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $apiKey',
      };

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          "amount": (double.parse(amount) * 100).toStringAsFixed(0), // Convert to cents as an integer
          "currency": "usd",
          "payment_method_types[]": "card", // You can specify other payment methods here
          "metadata[product_id]": productId,
        },
      );

      log(response.body);

      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> retrievePaymentIntent(String paymentIntentId) async {
    try {
      final String corsUrl = "https://corsproxy.io/?";
      final String baseUrl = '${corsUrl}https://api.stripe.com/v1/payment_intents/$paymentIntentId';

      var headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $apiKey',
      };

      var response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );

      log(response.body);

      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<void> refundPayment(String paymentId) async {
    try {
      final String corsUrl = "https://corsproxy.io/?";
      final String baseUrl = '${corsUrl}https://api.stripe.com/v1/refunds';

      var headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $apiKey',
      };

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          "payment_intent": paymentId,
        },
      );

      log(response.body);

      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      throw Exception(err.toString());
    }
  }
}
