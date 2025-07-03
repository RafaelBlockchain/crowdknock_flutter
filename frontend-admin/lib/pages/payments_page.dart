import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar
          const _Sidebar(activeTab: 'Payments'),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Payments',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 32),

                  Text(
                    'Monthly Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _MonthlySummaryRow(),
                  SizedBox(height: 40),

                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  PaymentsTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------- SIDEBAR ---------------------

class _Sidebar extends StatelessWidget {
  final String activeTab;
  const _Sidebar({required this.activeTab});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Dashboard',
      'Manage Users',
      'Manage Content',
      'Moderation',
      'Analytics',
      'Reports',
      'Payments',
      'Feedback',
      'Settings',
    ];

    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 24),
          for (final tab in tabs)
            NavButton(tab, tab == activeTab),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const NavButton(this.label, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: () {
          // TODO: Agregar navegación real con Navigator
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------- CARDS: MONTHLY SUMMARY ---------------------

class _MonthlySummaryRow extends StatelessWidget {
  const _MonthlySummaryRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: PaymentSummaryCard(label: 'Total Revenue', value: '\$8,320', color: Colors.green)),
        SizedBox(width: 16),
        Expanded(child: PaymentSummaryCard(label: 'Total Payouts', value: '\$4,120', color: Colors.indigo)),
        SizedBox(width: 16),
        Expanded(child: PaymentSummaryCard(label: 'Pending', value: '\$2,300', color: Colors.orange)),
      ],
    );
  }
}

class PaymentSummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const PaymentSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------- PAYMENTS TABLE ---------------------

class PaymentsTable extends StatelessWidget {
  const PaymentsTable({super.key});

  final List<List<String>> transactions = const [
    ['TX123456', 'jane.doe@example.com', '\$120.00', 'Completed', '2025-06-28'],
    ['TX123457', 'john.smith@example.com', '\$85.00', 'Pending', '2025-06-27'],
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: IntrinsicColumnWidth(),
      },
      border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade300)),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: const [
            Padding(padding: EdgeInsets.all(12), child: Text('Transaction ID', style: _headerStyle)),
            Padding(padding: EdgeInsets.all(12), child: Text('User', style: _headerStyle)),
            Padding(padding: EdgeInsets.all(12), child: Text('Amount', style: _headerStyle)),
            Padding(padding: EdgeInsets.all(12), child: Text('Status', style: _headerStyle)),
            Padding(padding: EdgeInsets.all(12), child: Text('Date', style: _headerStyle)),
            Padding(padding: EdgeInsets.all(12), child: SizedBox()), // Acción
          ],
        ),
        for (final tx in transactions)
          TableRow(
            children: [
              for (int i = 0; i < tx.length; i++)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    tx[i],
                    style: TextStyle(
                      fontSize: 13,
                      color: i == 3
                          ? (tx[i] == 'Completed' ? Colors.green : Colors.orange)
                          : Colors.black,
                      fontWeight: i == 3 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Acción como ver detalle, reenviar pago, etc.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('View'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

const TextStyle _headerStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
