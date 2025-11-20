import 'package:flutter/material.dart';
import 'pesanan_page.dart';

class OrderFormPage extends StatefulWidget {
  final String menuName;

  const OrderFormPage({super.key, required this.menuName});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final nameController = TextEditingController();
  final tableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesan ${widget.menuName}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Customer"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: tableController,
              decoration: const InputDecoration(labelText: "Nomor Meja"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PesananPage(
                      name: nameController.text,
                      table: tableController.text,
                      item: widget.menuName,
                      orders: [],
                    ),
                  ),
                );
              },
              child: const Text("Kirim Pesanan"),
            ),
          ],
        ),
      ),
    );
  }
}
