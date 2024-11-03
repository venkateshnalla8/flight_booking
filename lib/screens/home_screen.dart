import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../provider/flight_provider.dart';
import '../utils/city_data.dart';
import 'booking_summary_screen.dart';
import 'error_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Flights')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: const Text('Round Trip')),
                TextButton(onPressed: () {}, child: const Text('One Way')),
                TextButton(onPressed: () {}, child: const Text('Multi City')),
              ],
            ),
            // Departure City Field with Suggestions
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: const InputDecoration(labelText: 'From'),
                onChanged: (value) => flightProvider.setDepartureCity(value),
              ),
              suggestionsCallback: (pattern) {
                return cities.where((city) =>
                    city.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion.toString()));
              },
              onSuggestionSelected: (suggestion) {
                flightProvider.setDepartureCity(suggestion.toString());
              },
            ),
            // Arrival City Field with Suggestions
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: const InputDecoration(labelText: 'To'),
                onChanged: (value) => flightProvider.setArrivalCity(value),
              ),
              suggestionsCallback: (pattern) {
                return cities.where((city) =>
                    city.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion.toString()));
              },
              onSuggestionSelected: (suggestion) {
                flightProvider.setArrivalCity(suggestion.toString());
              },
            ),
            // Date Picker for Departure Date
            TextField(
              decoration: const InputDecoration(
                labelText: 'Depart',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  flightProvider.setDepartureDate(pickedDate);
                }
              },
            ),
            // Date Picker for Return Date
            TextField(
              decoration: const InputDecoration(
                labelText: 'Return',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  flightProvider.setReturnDate(pickedDate);
                }
              },
            ),
            // Class Dropdown
            DropdownButton<String>(
              value: flightProvider.travelClass,
              items: const [
                DropdownMenuItem(value: 'Show all', child: Text('Show all')),
                DropdownMenuItem(value: 'Business / First', child: Text('Business / First')),
                DropdownMenuItem(value: 'Economy', child: Text('Economy')),
              ],
              onChanged: (value) {
                if (value != null) {
                  flightProvider.setTravelClass(value);
                }
              },
              isExpanded: true,
              hint: const Text("Class"),
            ),
            // Passengers Count
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Passengers',
              ),
              onChanged: (value) {
                int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  flightProvider.setPassengerCount(count);
                }
              },
            ),
            const SizedBox(height: 20),
            // Search Button
            ElevatedButton(
              onPressed: () {
                if (flightProvider.validateInputs()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BookingSummaryScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ErrorScreen()),
                  );
                }
              },
              child: const Text('Search Flights'),
            ),
          ],
        ),
      ),
    );
  }
}
