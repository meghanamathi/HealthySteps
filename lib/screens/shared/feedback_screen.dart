import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int userRating = 0; // renamed from rating to avoid Flutter conflict
  final TextEditingController feedbackController = TextEditingController();
  bool isLoading = false;

  Future<void> submitFeedback() async {
    if (userRating == 0 || feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('fill_all_fields'.tr())),
      );
      return;
    }

    setState(() => isLoading = true);
    final success = await ApiService.submitFeedback(userRating, feedbackController.text);
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(success ? 'feedback_success'.tr() : 'feedback_failed'.tr()),
      ),
    );

    if (success) {
      feedbackController.clear();
      setState(() => userRating = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // soft green
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text('feedback'.tr(), style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(Icons.rate_review, size: 80, color: Colors.green.shade700),
            const SizedBox(height: 15),
            Text(
              'rate_quality'.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
                fontFamily: 'NotoSansTelugu',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // ⭐ Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () => setState(() => userRating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 30),

            // 💬 Feedback TextField
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'feedback_hint'.tr(),
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 📩 Submit Button
            ElevatedButton.icon(
              onPressed: isLoading ? null : submitFeedback,
              icon: const Icon(Icons.send, color: Colors.white),
              label: isLoading
                  ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
                  : Text(
                'submit_feedback'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
              ),
            ),
            const SizedBox(height: 20),

            // 🌿 Tagline
            Text(
              "healthy_steps_tagline".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
                fontFamily: 'NotoSansTelugu',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
