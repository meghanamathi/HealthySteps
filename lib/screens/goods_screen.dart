import 'package:flutter/material.dart';
import '../services/api_service.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({super.key});

  @override
  State<GoodsScreen> createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  Map<String, bool> items = {
    "Milk": false,
    "Eggs": false,
    "Balamrutam": false,
  };
  bool loading = false;

  void confirmGoods() async {
    setState(() => loading = true);
    final success = await ApiService.confirmGoods(items);
    setState(() => loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Goods confirmed!' : 'Failed to confirm')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Confirm Received Goods', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ...items.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: items[key],
            onChanged: (val) => setState(() => items[key] = val ?? false),
          );
        }),
        ElevatedButton(
          onPressed: loading ? null : confirmGoods,
          child: loading ? const CircularProgressIndicator() : const Text('Submit'),
        ),
      ],
    );
  }
}
