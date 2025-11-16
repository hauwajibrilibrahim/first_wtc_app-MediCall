import 'package:first_app/model/hospital.dart';
import 'package:flutter/material.dart';


class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.hospital,
  });

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    hospital.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    hospital.address,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.green, size: 40),
                      Icon(
                        Icons.message,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(hospital.description,
                    textAlign: TextAlign.center,),
                ],
              ),
            );
          },
        );
      },
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.add_box_outlined),
      ),
      title: Text(
        hospital.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${hospital.numberOfAmbulances} Ambulances Available"),
    );
  }
}