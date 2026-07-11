// format currency helper
String formatCurrency(int value) {
  if (value >= 1000000) {
    return '\$${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    return '\$${(value / 1000).toStringAsFixed(0)}k';
  } else {
    return '\$${value.toString()}';
  }
}
