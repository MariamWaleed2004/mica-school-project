// lib/features/canteen/presentation/screens/top_up_page.dart

import 'package:flutter/material.dart';

class TopUpWidget extends StatefulWidget {
  final bool isArabic;
  final Color themeColor;
  
  const TopUpWidget({
    super.key,
    required this.isArabic,
    required this.themeColor,
  });

  @override
  State<TopUpWidget> createState() => _TopUpWidgetState();
}

class _TopUpWidgetState extends State<TopUpWidget> {
  final TextEditingController _amountController = TextEditingController(text: "100");
  final TextEditingController _pinController = TextEditingController();
  int? selectedQuickAmount = 100;
  String selectedMethod = "card";
  String? pinError;

  void _showSuccessBanner(String msg) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF10B981)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(entry);
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
      if (mounted) Navigator.pop(context);
    });
  }

  void _handleConfirmation() {
    final pin = _pinController.text;
    if (pin.isEmpty) {
      setState(() => pinError = widget.isArabic ? "يرجى إدخال الرقم السري" : "Enter PIN");
    } else if (pin.startsWith('0') || double.tryParse(pin) == null) {
      setState(() => pinError = widget.isArabic ? "الرقم السري غير صحيح" : "Invalid PIN");
    } else {
      setState(() => pinError = null);
      _showSuccessBanner(
        widget.isArabic
            ? "تمت عملية الشحن بنجاح ✅ ${_amountController.text} ج.م"
            : "Top up successful ✅ ${_amountController.text} EGP",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
        body: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.isArabic ? "شحن المحفظة" : "Top Up Wallet",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      const SizedBox(width: 38),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    
                    // Quick amounts
                    _sectionLabel(widget.isArabic ? "اختر مبلغاً سريعاً" : "Quick Amount", textColor),
                    const SizedBox(height: 12),
                    Row(
                      children: [50, 100, 250, 500].map((amt) {
                        final isSelected = selectedQuickAmount == amt;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              selectedQuickAmount = amt;
                              _amountController.text = amt.toString();
                            }),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF1D4ED8) : cardColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey.withOpacity(0.2),
                                ),
                                boxShadow: isSelected
                                    ? [BoxShadow(color: const Color(0xFF1D4ED8).withOpacity(0.3), blurRadius: 10)]
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "$amt",
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.isArabic ? "ج.م" : "EGP",
                                    style: TextStyle(
                                      color: isSelected ? Colors.white70 : textColor.withOpacity(0.5),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(height: 24),
                    _sectionLabel(widget.isArabic ? "المبلغ" : "Amount", textColor),
                    const SizedBox(height: 10),
                    _inputField(
                      isDark, cardColor, textColor,
                      controller: _amountController,
                      hint: widget.isArabic ? "أدخل المبلغ" : "Enter amount",
                      icon: Icons.payments_rounded,
                      keyboardType: TextInputType.number,
                      suffix: widget.isArabic ? "ج.م" : "EGP",
                    ),
                    
                    const SizedBox(height: 16),
                    _sectionLabel("PIN", textColor),
                    const SizedBox(height: 10),
                    _inputField(
                      isDark, cardColor, textColor,
                      controller: _pinController,
                      hint: "••••",
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                    ),
                    
                    if (pinError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.error_rounded, color: Colors.redAccent, size: 15),
                            const SizedBox(width: 6),
                            Text(pinError!, style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    
                    const SizedBox(height: 24),
                    _sectionLabel(widget.isArabic ? "طريقة الدفع" : "Payment Method", textColor),
                    const SizedBox(height: 12),
                    _methodTile(
                      "card", Icons.credit_card_rounded,
                      widget.isArabic ? "بطاقة بنكية" : "Credit Card",
                      isDark, cardColor, textColor,
                    ),
                    _methodTile(
                      "wallet", Icons.account_balance_wallet_rounded,
                      "Vodafone Cash", isDark, cardColor, textColor,
                    ),
                    
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _handleConfirmation,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF059669), Color(0xFF10B981)]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFF10B981).withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 6)),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            widget.isArabic ? "تأكيد الشحن" : "Confirm Top Up",
                            style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String t, Color textColor) {
    return Text(
      t,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: textColor.withOpacity(0.6)),
    );
  }

  Widget _inputField(
    bool isDark, Color cardColor, Color textColor, {
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    int? maxLength,
    TextInputType? keyboardType,
    String? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.1 : 0.04), blurRadius: 8),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLength: maxLength,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textColor.withOpacity(0.3)),
          prefixIcon: Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
          suffixText: suffix,
          suffixStyle: TextStyle(color: textColor.withOpacity(0.5), fontWeight: FontWeight.bold),
          border: InputBorder.none,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _methodTile(String id, IconData icon, String title, bool isDark, Color cardColor, Color textColor) {
    final isSelected = selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D4ED8).withOpacity(0.06) : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey.withOpacity(0.15),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF1D4ED8).withOpacity(0.1), blurRadius: 8)] : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: (isSelected ? const Color(0xFF1D4ED8) : Colors.grey).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: isSelected ? const Color(0xFF1D4ED8) : textColor)),
            ),
            if (isSelected)
              Container(
                width: 22, height: 22,
                decoration: const BoxDecoration(color: Color(0xFF1D4ED8), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }
}