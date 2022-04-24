import '../models/transaction.dart';

final DUMMY_TRANSACTION = {
  '1': Transaction(
      id: 'T1',
      category: 'Salário',
      description: 'Salário de Antonny',
      date: DateTime.now(),
      status: 'Pendente',
      type: 2,
      value: -1200.00),
  '2': Transaction(
      id: 'T2',
      category: 'Conta',
      description: 'Conta de Luz',
      date: DateTime.now(),
      status: 'Pendente',
      type: 2,
      value: -500.00),
  '3': Transaction(
      id: 'T3',
      category: 'Salário',
      description: 'Salário de Jonathan',
      date: DateTime.now(),
      status: 'Pendente',
      type: 2,
      value: -900.00),
  '4': Transaction(
      id: 'T4',
      category: 'Pagamento',
      description: 'Pagamento pelo sistema',
      date: DateTime.now(),
      status: 'Pendente',
      type: 1,
      value: 3000.00),
};
