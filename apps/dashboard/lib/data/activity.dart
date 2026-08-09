import 'models.dart';

const activityEvents = <ActivityEvent>[
  ActivityEvent(
    title: 'New customer',
    detail: 'Camila joined the Business plan',
    relativeTime: '12 min ago',
    kind: .customer,
  ),
  ActivityEvent(
    title: 'Payment received',
    detail: 'ORD-1048 · \$1,249.00',
    relativeTime: '38 min ago',
    kind: .payment,
  ),
  ActivityEvent(
    title: 'Order requires review',
    detail: 'ORD-1047 is awaiting confirmation',
    relativeTime: '1 hr ago',
    kind: .alert,
  ),
  ActivityEvent(
    title: 'Order fulfilled',
    detail: 'ORD-1046 shipped to Ava Wilson',
    relativeTime: '3 hrs ago',
    kind: .order,
  ),
  ActivityEvent(
    title: 'New customer',
    detail: 'Henry accepted his invitation',
    relativeTime: '5 hrs ago',
    kind: .customer,
  ),
  ActivityEvent(
    title: 'Refund processed',
    detail: 'ORD-1045 · \$189.00',
    relativeTime: 'Yesterday',
    kind: .payment,
  ),
];
