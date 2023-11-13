import 'package:flowcash/controllers/splash_screen_controller.dart';
import 'package:flowcash/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';
import '../../utils/alert/alert_dialog.dart';
import '../../utils/loading_alert.dart';
import '../../utils/messages.dart';

part 'get_transaction_calculations.dart';
part 'get_transactions.dart';
part 'create_transaction.dart';
part 'update_transaction.dart';
part 'delete_transaction.dart';

class TransactionController extends GetxController {
  final transactions = <Transaction>[].obs;
  final dayTransactions = <Transaction>[].obs;
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    refreshHome();
    super.onInit();
  }

  refreshHome() {
    getTransanctions();
  }

  void setDate(DateTime _newDate) {
    selectedDate.value = _newDate;

    // getTransanctions();
  }

  void getTransanctions() => implementGetTransactions();

  static Map<String, dynamic> getTransactionCalculations({
    required List<dynamic> actualTransaction,
    required List<dynamic> allTransaction,
  }) {
    return implementGetTransactionCalculations(
      actualTransaction: actualTransaction,
      allTransaction: allTransaction,
    );
  }

  static Future<void> createTransaction({
    required BuildContext context,
    required Map<String, dynamic> newTransaction,
    required Function() onRefresh,
  }) {
    return implementCreateTransaction(
      context: context,
      newTransaction: newTransaction,
      onRefresh: onRefresh,
    );
  }

  static Future<void> updateTransaction({
    required BuildContext context,
    required int transactionId,
    required Map<String, dynamic> updateTransaction,
    required Function() onRefresh,
  }) {
    return implementUpdateTransaction(
      context: context,
      transactionId: transactionId,
      updateTransaction: updateTransaction,
      onRefresh: onRefresh,
    );
  }

  static Future<void> deleteTransaction({
    required BuildContext context,
    required int id,
    required Function() onRefresh,
  }) {
    return implementDeleteTransaction(
      context: context,
      id: id,
      onRefresh: onRefresh,
    );
  }
}