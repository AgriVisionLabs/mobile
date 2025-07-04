Map soil = {'Sandy': 0, 'Clay': 1, 'Loamy': 2};

String? getSoilName(int soiltype) {

    return soil.entries
        .firstWhere(
          (entry) => entry.value == soiltype,
          orElse: () => const MapEntry('Unknown', null),
        )
        .key;
  }