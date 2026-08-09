enum CustomerStatus { active, invited, suspended }

enum OrderStatus { paid, pending, refunded, cancelled }

class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.plan,
    required this.status,
    required this.joinedAt,
  });

  final String id;
  final String name;
  final String email;
  final String plan;
  final CustomerStatus status;
  final DateTime joinedAt;

  String get initials =>
      name.split(' ').take(2).map((part) => part.substring(0, 1)).join();
}

class Order {
  const Order({
    required this.id,
    required this.customer,
    required this.date,
    required this.amount,
    required this.status,
  });

  final String id;
  final String customer;
  final DateTime date;
  final double amount;
  final OrderStatus status;
}

class ActivityEvent {
  const ActivityEvent({
    required this.title,
    required this.detail,
    required this.relativeTime,
    required this.kind,
  });

  final String title;
  final String detail;
  final String relativeTime;
  final ActivityKind kind;
}

enum ActivityKind { customer, order, payment, alert }
