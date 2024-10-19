import 'suitcase.dart';

class GameState {
  final List<Suitcase> suitcases;
  final int? holdSuitcaseId;
  final double? offer;
  final bool gameOver;

  GameState({
    required this.suitcases,
    this.holdSuitcaseId,
    this.offer,
    this.gameOver = false,
  });

// Calculate the offer -> 90% of avg
double calculateOffer() {
  double totalValue = 0;
  int count = 0;

  //Loop through each suitcase to calculate the total value and count the unrevealed ones.
  for (final suitcase in suitcases) {
    if (!suitcase.isRevealed) { // Check if the suitcase is not revealed
      totalValue += suitcase.value; // Add its value to totalValue
      count++; // Increment the count of remaining suitcases
    }
  }

  //calc the average value. If count is zero, set average to zero.
  double averageValue = (count > 0) ? totalValue / count : 0;

  //get 90% of the average value as the dealer's offer.
  return averageValue * 0.9; // Multiply by 0.9 for the offer
}
}