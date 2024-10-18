// ignore: file_names
Future<double> getPredictedUnits(double startingEnergyVal, double currEnergyVal,
    DateTime currDatetime, DateTime startingDatetime) async {
  ////
  double predictedUnits = 0.0;
  Duration difference = currDatetime.difference(startingDatetime);

  int numberOfDays = difference.inDays;

  /////////////////////////////  main Calculation  ////////////

  predictedUnits = (((currEnergyVal - startingEnergyVal) / numberOfDays)) * 30;

  return predictedUnits;
}
