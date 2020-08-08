void main() {
  List<int> val = List();
  val.add(56);
  val.add(27);
  val.add(167);
  val.add(108);
  val.add(36);

  int max = val[1];
  for (int e in val) {
    if (e > max) max = e;
  }
  print("Largest Element in the List is $max");
}
