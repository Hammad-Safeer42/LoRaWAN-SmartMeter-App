Future<double> getPredictedBillpkr(
  double unitrate,
  double predictedunits,
  double quaterlyAdjusments,
  double additionalSurcharage,
  double surcharge,
  double electricDuty,
  double salesTax,
  double incometax,
  double tvFee,
  double numOfTVs,
  bool taxExemption,
  double minCharges,
) async {
  ////
  double predictedBillpkr = 0.0;
  double electricCharges = 0.0;
  double variableCharges = 0.0;

////////////////////////////      main calculation Part      ///////////////////
////////////////////////////      main calculation Part      ///////////////////
////////////////////////////      main calculation Part      ///////////////////
////////////////////////////      main calculation Part      ///////////////////
////////////////////////////      main calculation Part      ///////////////////

  if (predictedunits > 4) {
    variableCharges = unitrate * predictedunits;

    /////////////////////////

    electricCharges = variableCharges +
        quaterlyAdjusments +
        additionalSurcharage * predictedunits +
        surcharge * predictedunits;

    //
    if (taxExemption) {
      predictedBillpkr = electricCharges +
          electricCharges * salesTax +
          electricDuty * electricCharges +
          tvFee * numOfTVs;
    } else {
      if (electricCharges > 25000) {
        predictedBillpkr = electricCharges +
            electricCharges * salesTax +
            electricDuty * electricCharges +
            tvFee * numOfTVs +
            incometax * electricCharges;

        //
      } else {
        predictedBillpkr = electricCharges +
            electricCharges * salesTax +
            electricDuty * electricCharges +
            tvFee * numOfTVs;
      }
    }
  } else {
    variableCharges = unitrate * predictedunits + minCharges;

    /////////////////////////

    electricCharges = variableCharges +
        quaterlyAdjusments +
        additionalSurcharage * predictedunits +
        surcharge * predictedunits;

    //
    if (taxExemption) {
      predictedBillpkr = electricCharges +
          electricCharges * salesTax +
          electricDuty * electricCharges +
          tvFee * numOfTVs;
    } else {
      if (electricCharges > 25000) {
        predictedBillpkr = electricCharges +
            electricCharges * salesTax +
            electricDuty * electricCharges +
            tvFee * numOfTVs +
            incometax * electricCharges;

        //
      } else {
        predictedBillpkr = electricCharges +
            electricCharges * salesTax +
            electricDuty * electricCharges +
            tvFee * numOfTVs;
      }
    }
  }
  return predictedBillpkr;
}
