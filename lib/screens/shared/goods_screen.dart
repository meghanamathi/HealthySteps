import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/api_service.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({super.key});

  @override
  State<GoodsScreen> createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  Map<String, bool> items = {
    'milk': false,
    'eggs': false,
    'balamrutam': false,
  };

  bool isLoading = false;

  Future<void> confirmGoods() async {
    setState(() => isLoading = true);
    final success = await ApiService.confirmGoods(items);
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(success ? 'goods_confirmed'.tr() : 'goods_failed'.tr()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text('goods'.tr(), style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(Icons.shopping_basket, size: 70, color: Colors.green.shade700),
            const SizedBox(height: 15),
            Text(
              'confirm_goods'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                children: [
                  _buildItemCard(
                      Icons.local_drink, 'milk'.tr(), items['milk']!, 'milk'),
                  _buildItemCard(
                      Icons.egg, 'eggs'.tr(), items['eggs']!, 'eggs'),
                  _buildItemCard(Icons.food_bank, 'balamrutam'.tr(),
                      items['balamrutam']!, 'balamrutam'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Submit button
            ElevatedButton.icon(
              onPressed: isLoading ? null : confirmGoods,
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('submit'.tr(),
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(
      IconData icon, String title, bool value, String keyName) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4CAF50), size: 40),
        title: Text(title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
        trailing: Checkbox(
          value: value,
          activeColor: Colors.green,
          onChanged: (checked) {
            setState(() => items[keyName] = checked ?? false);
          },
        ),
      ),
    );
  }
}
