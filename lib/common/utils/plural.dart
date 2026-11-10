String plural(int count, String one, String few, String many) {
  final n = count.abs();
  final lastTwo = n % 100;
  if (lastTwo >= 11 && lastTwo <= 14) return many;
  return switch (n % 10) {
    1 => one,
    2 || 3 || 4 => few,
    _ => many,
  };
}
