import 'package:grd_proj/components/onboarding_Info.dart';

class OnboardingData {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Welcome to our Agrivision app!",
        description:
        "We aim to be your primary partner in boosting your agricultural productivity and simplifying your daily operations.",
        image: "assets/images/sunset.jpg",
        button: "Let Get Started"),
    OnboardingInfo(
        title: "Monitor, Manage, and Protect",
        description:
        "Detect and address crop diseases early to ensure healthy yields and maximize productivity. Stay in control with real-time data insights, automated processes, and tailored recommendations.",
        image: "assets/images/farmer.jpg",
        button : "continue"),
    OnboardingInfo(
        title: "Join the Future of Farming",
        description:
        "Create your account today and unlock advanced tools to transform your agricultural operations.",
        image: 'assets/images/plants.jpg',
        button: "Get Started"),
  ];
}
