import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Property')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text(_selectedDate == null ? 'Choose Date' : 'Selected: ${_selectedDate!.toLocal()}'.split(' ')[0]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedDate == null ? null : () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking Confirmed for ${_selectedDate!.toLocal()}'.split(' ')[0]))
                );
              },
              child: Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
