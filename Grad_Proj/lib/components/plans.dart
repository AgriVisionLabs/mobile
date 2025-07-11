class Plans {
  final String title;
  final String numberOfFarms;
  final String numberOfFields;
  final List features;
  final String price;

  Plans(
      {required this.title,
      required this.numberOfFarms,
      required this.numberOfFields,
      required this.features,
      required this.price});
}

class PlansData {
  List<Plans> items = [
    Plans(
        title: "Basic",
        numberOfFarms: "1 farm",
        numberOfFields: "Up to 3 Fields",
        price: "free",
        features: [
          "Access to the dashboard for farm and field management.",
          "Basic soil health and weather insights.",
          "AI-powered disease detection for limited usage."
        ]),
    Plans(
        title: "ِAdvanced",
        numberOfFarms: "Up to 3 farms",
        numberOfFields: "5 fields per farm",
        price: "499.99 L.E / month",
        features: [
          "All Free Plan features.",
          "Advanced analytics and predictive insights.",
          "Unlimited AI-powered disease detection.",
          "Customizable automation rules for irrigation and sensor integration."
        ]),
    Plans(
        title: "Enterprise",
        numberOfFarms: "Unlimited farms",
        numberOfFields: "Unlimited fields per farm",
        price: "Custom",
        features: [
          "All Advanced Plan features.",
          "Advanced analytics and predictive insights.",
          "Unlimited AI-powered disease detection.",
          "Dedicated account manager for personalized support."
        ]),
  ];
}
