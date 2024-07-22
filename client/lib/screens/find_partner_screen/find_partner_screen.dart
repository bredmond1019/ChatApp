import 'package:client/models/availability.dart';
import 'package:client/screens/find_partner_screen/queryAvailablePartners.graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class FindPartnerScreen extends HookWidget {
  const FindPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final client = useGraphQLClient();
    final timeList = _generateTimeList();

    final climbingGym = useState<String>('gym1');
    final startTime = useState<String>(timeList[0]);
    final endTime = useState<String>(timeList[0]);
    final date =
        useState<String>(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    final loading = useState(false);

    Future<void> findPartner() async {
      loading.value = true;

      NewAvailability availabilityParams = NewAvailability(
        gymId: climbingGym.value,
        date: date.value,
        startTime: startTime.value,
        endTime: endTime.value,
      );

      print('Availability Params: ${availabilityParams.toJson()}');

      final QueryOptions options = QueryOptions(
        document: documentNodeQuerySearchAvailability,
        variables: availabilityParams.toJson(),
      );

      try {
        final QueryResult result = await client.query(options);

        if (!context.mounted) return;

        if (result.hasException) {
          print('Error: ${result.exception.toString()}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${result.exception.toString()}')),
          );
        } else if (result.data != null) {
          final responseData = result.data!;
          print('Partner found: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Partner found successfully!')),
          );
          Navigator.pushNamed(context, '/user_list');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data received')),
          );
        }
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Partner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: climbingGym.value,
              onChanged: (value) {
                climbingGym.value = value!;
              },
              items: const [
                DropdownMenuItem(value: 'gym1', child: Text('Gym 1')),
                DropdownMenuItem(value: 'gym2', child: Text('Gym 2')),
              ],
              decoration: const InputDecoration(labelText: 'Select Gym'),
            ),
            TextField(
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16

                  date.value = formattedDate;
                } else {}
              },
            ),
            const SizedBox(height: 16.0),
            // Time Pickers
            DropdownButtonFormField<String>(
              value: startTime.value,
              onChanged: (value) {
                startTime.value = value!;
              },
              items: timeList.map((time) {
                return DropdownMenuItem(value: time, child: Text(time));
              }).toList(),
              decoration: const InputDecoration(labelText: 'Select Start Time'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: endTime.value,
              onChanged: (value) {
                endTime.value = value!;
              },
              items: timeList.map((time) {
                return DropdownMenuItem(value: time, child: Text(time));
              }).toList(),
              decoration: const InputDecoration(labelText: 'Select End Time'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: loading.value ? null : findPartner,
              child: loading.value
                  ? const CircularProgressIndicator()
                  : const Text('Find Partner'),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _generateTimeList() {
    List<String> times = [];
    for (int hour = 0; hour < 24; hour++) {
      times.add('${hour.toString().padLeft(2, '0')}:00');
      times.add('${hour.toString().padLeft(2, '0')}:30');
    }
    return times;
  }
}
