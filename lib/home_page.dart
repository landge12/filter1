import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedOption = 'Most Recent';
  String selectedFilter = 'All';

  // Function to display the bottom sheet
  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to manage the state inside the BottomSheet
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter by',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Filter buttons row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFilterButton('All', setModalState),
                        const SizedBox(width: 10),
                        buildFilterButton('You will get', setModalState),
                        const SizedBox(width: 10),
                        buildFilterButton('You will give', setModalState),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Filter buttons row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFilterButton('Settled', setModalState),
                        const SizedBox(width: 10),
                        buildFilterButton('Due Today', setModalState),
                        const SizedBox(width: 10),
                        buildFilterButton('Upcoming', setModalState),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Filter button row 3
                    Row(
                      children: [
                        buildFilterButton('No Due Date', setModalState),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sort by',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Radio button options
                    Column(
                      children: [
                        buildRadioOption('Most Recent', setModalState),
                        buildRadioOption('Highest Amount', setModalState),
                        buildRadioOption('By Name (A-Z)', setModalState),
                        buildRadioOption('Oldest', setModalState),
                        buildRadioOption('Least Amount', setModalState),
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                      ),
                      onPressed: () {
                        // Add your action logic for the button
                      },
                      child: const Center(
                        child: Text(
                          'VIEW RESULT',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => _openBottomSheet(context),
          child: const Icon(
            Icons.filter_alt_sharp,
            size: 48,
          ),
        ),
      ),
    );
  }

  // Helper method for radio options
  Widget buildRadioOption(String title, StateSetter setModalState) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 2),
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: _selectedOption == title ? FontWeight.bold : FontWeight.normal,
            color: _selectedOption == title ? Colors.blue[800] : Colors.grey[800],
          ),
        ),
        trailing: Radio<String>(
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setModalState(() {
              _selectedOption = value!; // Update the selected radio option
            });
          },
          activeColor: Colors.blue[800],
          value: title,
        ),
      ),
    );
  }

  // Helper method to build filter buttons
  Widget buildFilterButton(String title, StateSetter setModalState) {
    final bool isSelected = selectedFilter == title;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setModalState(() {
            selectedFilter = title; // Update selected filter
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? Colors.blue[900] : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
