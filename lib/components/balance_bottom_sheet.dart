import 'package:flutter/material.dart';

class AccountBalanceSheet extends StatefulWidget {
  const AccountBalanceSheet({super.key});

  @override
  State<AccountBalanceSheet> createState() => _AccountBalanceSheetState();
}

class _AccountBalanceSheetState extends State<AccountBalanceSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Balance data - only one can be true at a time
  final Map<String, bool> balances = {'USD': true, 'LBP': false, 'AED': false};

  final Map<String, String> amounts = {
    'USD': '1000 \$',
    'LBP': '10,000,000 LBP',
    'AED': '500AED',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Title
          Text(
            'Account Balance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black87,
              unselectedLabelColor: const Color(0xFF999999),
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'All Balance'),
                Tab(text: 'Balance In'),
                Tab(text: 'Balance Out'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Balance List
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children:
                  balances.entries.map((entry) {
                    return _buildBalanceItem(
                      currency: entry.key,
                      amount: amounts[entry.key]!,
                      isEnabled: entry.value,
                      onToggle: (value) {
                        setState(() {
                          if (value) {
                            // Turn off all other toggles
                            balances.updateAll((key, _) => false);
                            // Turn on the selected toggle
                            balances[entry.key] = true;
                          }
                          // If trying to turn off, keep it on (at least one must be active)
                          // Remove the else block if you want to allow all toggles to be off
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBalanceItem({
    required String currency,
    required String amount,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Currency Code
            SizedBox(
              width: 50,
              child: Text(
                currency,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Amount
            Expanded(
              child: Text(
                amount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? theme.colorScheme.primary : Colors.black87,
                ),
              ),
            ),
            // Toggle Switch
            Transform.scale(
              scale: 0.85,
              child: Switch(
                value: isEnabled,
                onChanged: onToggle,
                activeColor: theme.colorScheme.primary,
                activeTrackColor: theme.colorScheme.primary.withOpacity(0.5),
                inactiveThumbColor: Colors.grey.shade400,
                inactiveTrackColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage: Show the bottom sheet
void showAccountBalanceSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const AccountBalanceSheet(),
  );
}
