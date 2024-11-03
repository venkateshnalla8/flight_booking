import 'package:flutter/foundation.dart';

class FlightProvider with ChangeNotifier {
  String _departureCity = '';
  String _arrivalCity = '';
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengerCount = 1;
  String _travelClass = 'Show all';

  // Getters
  String get departureCity => _departureCity;
  String get arrivalCity => _arrivalCity;
  DateTime? get departureDate => _departureDate;
  DateTime? get returnDate => _returnDate;
  int get passengerCount => _passengerCount;
  String get travelClass => _travelClass;

  // Setters
  void setDepartureCity(String city) {
    _departureCity = city;
    notifyListeners();
  }

  void setArrivalCity(String city) {
    _arrivalCity = city;
    notifyListeners();
  }

  void setDepartureDate(DateTime date) {
    _departureDate = date;
    notifyListeners();
  }

  void setReturnDate(DateTime date) {
    _returnDate = date;
    notifyListeners();
  }

  void setPassengerCount(int count) {
    _passengerCount = count;
    notifyListeners();
  }

  void setTravelClass(String travelClass) {
    _travelClass = travelClass;
    notifyListeners();
  }

  bool validateInputs() {
    return _departureCity.isNotEmpty && _arrivalCity.isNotEmpty && _departureDate != null;
  }
}
