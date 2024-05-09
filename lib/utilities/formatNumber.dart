String formatNumber(int num) {
  if (num >= 1000 && num < 1000000) {
    return (num / 1000).toStringAsFixed(1) + 'k';
  } else if (num >= 1000000) {
    return (num / 1000000).toStringAsFixed(1) + 'M';
  } else {
    return num.toString();
  }
}
