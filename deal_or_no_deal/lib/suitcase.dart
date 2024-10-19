class Suitcase {
  final int id; //to identify
  final int value; //how much it's worth
  bool isRevealed; //have we revealed it yet?

  Suitcase({required this.id, required this.value, this.isRevealed = false}); //default is false
}