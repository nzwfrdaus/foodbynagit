import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_model.dart';
import '../providers/cart_provider.dart';

class DetailPage extends StatefulWidget {
  final MenuModel menu;

  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F9),
      appBar: AppBar(
        title: Text(widget.menu.name),
        backgroundColor: const Color(0xFF5C3C96),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Gambar Menu
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.menu.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Nama & Harga
            Text(
              widget.menu.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3C96),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Rp ${widget.menu.price}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Deskripsi
            const Text(
              "Deskripsi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3C96),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.menu.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

            const SizedBox(height: 30),

            // 🔹 Qty Selector
            Row(
              children: [
                const Text(
                  "Jumlah:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(),

                // Tombol -
                IconButton(
                  onPressed: () {
                    if (qty > 1) {
                      setState(() => qty--);
                    }
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Color(0xFF5C3C96),
                  ),
                ),

                Text(
                  qty.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Tombol +
                IconButton(
                  onPressed: () {
                    setState(() => qty++);
                  },
                  icon: const Icon(Icons.add_circle, color: Color(0xFF5C3C96)),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Tombol Tambah ke Pesanan
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C3C96),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  // Tambah sebanyak qty ke cart
                  for (int i = 0; i < qty; i++) {
                    cart.addToCart(widget.menu);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${widget.menu.name} ditambahkan ke pesanan!",
                      ),
                      backgroundColor: const Color(0xFF5C3C96),
                    ),
                  );
                },
                child: const Text(
                  "Tambah ke Pesanan",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
