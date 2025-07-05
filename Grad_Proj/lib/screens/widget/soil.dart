Map soil = {'Sandy': 1, 'Clay': 2, 'Loamy': 3};

String? getSoilName(int soiltype) {

    return soil.entries
        .firstWhere(
          (entry) => entry.value == soiltype,
          orElse: () => const MapEntry('Unknown', null),
        )
        .key;
  }