import 'package:flutter/material.dart';

class SummaryBottomSheet extends StatelessWidget {
  const SummaryBottomSheet({
    super.key,
    required this.insulationTotals,
  });

  final Map<String, double> insulationTotals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.summarize_outlined,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Sammanfattning",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
                tooltip: 'Stäng',
              ),
            ],
          ),
        ),

        // Content
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (insulationTotals.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Inga rör har lagts till ännu.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: insulationTotals.entries.length,
                      itemBuilder: (context, index) {
                        final entry = insulationTotals.entries.elementAt(index);
                        final isEvenRow = index % 2 == 0;

                        return Column(
                          children: [
                            Container(
                              color: isEvenRow
                                  ? Colors.transparent
                                  : theme.primaryColor.withValues(alpha: .05),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                leading: Icon(
                                  Icons.layers,
                                  color: theme.primaryColor,
                                ),
                                title: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                trailing: Text(
                                  "${entry.value.ceil()} m²",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (index < insulationTotals.entries.length - 1)
                              const Divider(height: 1),
                          ],
                        );
                      },
                    ),
                  ),
                if (insulationTotals.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text("Stäng"),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
