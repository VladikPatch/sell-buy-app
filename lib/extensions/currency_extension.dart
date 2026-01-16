extension CurrencyDisplay on int {
  String get asCurrency => '\$${(this / 100).toStringAsFixed(2)}';
}
