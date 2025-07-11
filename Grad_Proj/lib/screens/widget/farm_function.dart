String getTemp(int temp) {
  if (temp >=35) {
    return "Hot";
  } else if (temp>= 45 ) {
    return "Very Hot";
  } else {
    return "Good";
  }
}