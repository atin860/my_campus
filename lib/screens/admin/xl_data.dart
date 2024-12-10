import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadAndDisplayPage extends StatefulWidget {
  @override
  _UploadAndDisplayPageState createState() => _UploadAndDisplayPageState();
}

class _UploadAndDisplayPageState extends State<UploadAndDisplayPage> {
  List<Map<String, dynamic>> data = [];
  String selectedBranch = "All";
  String selectedYear = "All";
  List<String> branches = ["All", "CSE", "ECE", "EEE", "MECH"];
  List<String> years = ["All", "1st Year", "2nd Year", "3rd Year", "4th Year"];

  // Fetch data from Firebase
  Future<void> fetchData() async {
    var collection = FirebaseFirestore.instance.collection('students');
    var querySnapshot = await collection.get();
    setState(() {
      data = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  // Upload Excel File
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      var fileBytes = result.files.single.bytes;
      var excel = Excel.decodeBytes(fileBytes!);

      List<Map<String, dynamic>> newData = [];
      for (var sheet in excel.tables.keys) {
        var table = excel.tables[sheet];
        if (table != null) {
          for (var row in table.rows.skip(1)) {
            // Skip the header row
            newData.add({
              "name": row[0]?.value,
              "roll_no": row[1]?.value,
              "branch": row[2]?.value,
              "year": row[3]?.value,
              "total_day": row[4]?.value,
              "present_day": row[5]?.value,
            });
          }
        }
      }

      // Save to Firebase
      for (var item in newData) {
        await FirebaseFirestore.instance.collection('students').add(item);
      }

      setState(() {
        data = newData;
      });
    }
  }

  // Show Required Columns Dialog
  void showRequiredColumns() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Required Column Names"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. name"),
              Text("2. roll_no"),
              Text("3. branch"),
              Text("4. year"),
              Text("5. total_day"),
              Text("6. present_day"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var filteredData = data.where((item) {
      return (selectedBranch == "All" || item['branch'] == selectedBranch) &&
          (selectedYear == "All" || item['year'] == selectedYear);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Upload and Display Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: uploadFile,
                    child: Text('Upload Excel File'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showRequiredColumns,
                    child: Text('View Required Columns'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedBranch,
                    onChanged: (value) {
                      setState(() {
                        selectedBranch = value!;
                      });
                    },
                    items: branches.map((branch) {
                      return DropdownMenuItem(
                          value: branch, child: Text(branch));
                    }).toList(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedYear,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value!;
                      });
                    },
                    items: years.map((year) {
                      return DropdownMenuItem(value: year, child: Text(year));
                    }).toList(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  var item = filteredData[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['name'] ?? ''),
                      subtitle: Text(
                          'Roll No: ${item['roll_no']}, Branch: ${item['branch']}, Year: ${item['year']}'),
                      trailing: Text(
                          'Present: ${item['present_day']}/${item['total_day']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
