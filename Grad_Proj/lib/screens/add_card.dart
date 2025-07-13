import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/widget/text.dart';

class StripeCardSetupScreen extends StatefulWidget {
  const StripeCardSetupScreen({Key? key}) : super(key: key);

  @override
  State<StripeCardSetupScreen> createState() => _StripeCardSetupScreenState();
}

class _StripeCardSetupScreenState extends State<StripeCardSetupScreen> {
  CardFieldInputDetails? _cardDetails;
  bool _loading = false;
  String _status = '';
  

  void _onCardChanged(CardFieldInputDetails? details) {
    setState(() {
      _cardDetails = details;
    });
  }

  Future<void> _handleSetupIntent() async {
    setState(() => _loading = true);

    try {
      // 1. تحضير client_secret من الـ backend أو mock
      final clientSecret = await _fetchSetupIntentClientSecret();

      // 2. تنفيذ SetupIntent مع بيانات بطاقة من CardField
      final setupIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: clientSecret,
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name: 'Test User',
              email: 'testuser@example.com',
              phone: '+201000000000',
              address: Address(
                city: 'Cairo',
                country: 'EG',
                line1: '123 Street',
                line2: '',
                postalCode: '12345',
                state: 'Giza',
              ),
            ),
          ),
        ),
      );

      setState(() {
        _status = '✅ Card saved! SetupIntent ID: ${setupIntent.id}';
      });
    } catch (e) {
      setState(() {
        _status = '❌ Error: ${e.toString()}';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  // مؤقتًا نرجع mock client_secret
  Future<String> _fetchSetupIntentClientSecret() async {
    return 'seti_123456789_secret_xxx'; // غيّريها لاحقًا بـ API حقيقية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  text(
                      fontSize: 24,
                      label: "Add a Bank Card",
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xff757575), size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFFE0E0E0), // لون الحدود الخفيف
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Card Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Monrope',
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CardField(
                      onCardChanged: _onCardChanged,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Monrope',
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cardDetails?.complete == true && !_loading
                    ? _handleSetupIntent
                    : null,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Save Card'),
              ),
              const SizedBox(height: 20),
              Text(_status),
            ],
          ),
        ),
      ),
    );
  }
}
