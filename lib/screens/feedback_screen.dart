import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 3;
  final feedbackController = TextEditingController();
  bool loading = false;

  void submitFeedback() async {
    setState(() => loading = true);
    final success = await ApiService.submitFeedback(rating, feedbackController.text);
    setState(() => loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Feedback submitted!' : 'Failed to submit feedback')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Rate the quality of goods', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Slider(
            value: rating.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: "$rating ⭐",
            onChanged: (val) => setState(() => rating = val.toInt()),
          ),
          TextField(
            controller: feedbackController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Write your feedback',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: loading ? null : submitFeedback,
            child: loading ? const CircularProgressIndicator() : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
