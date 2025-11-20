import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/menu_model.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({
    super.key,
    required String name,
    required String table,
    required String item,
    required List orders,
  });

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  String? namaPemesan;
  String? nomorMeja;

  final TextEditingController namaC = TextEditingController();
  final TextEditingController mejaC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openDialogNamaMeja();
    });
  }

  Future<void> _openDialogNamaMeja() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Data Pemesan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaC,
                decoration: const InputDecoration(
                  hintText: "Masukkan nama anda",
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: mejaC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Masukkan nomor meja",
                  labelText: "Nomor Meja",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (namaC.text.isNotEmpty && mejaC.text.isNotEmpty) {
                  Navigator.pop(context, {
                    "nama": namaC.text,
                    "meja": mejaC.text,
                  });
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        namaPemesan = result["nama"];
        nomorMeja = result["meja"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Pesanan"), centerTitle: true),

      body: nomorMeja == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDataPemesanBox(),

                  const SizedBox(height: 20),

                  const Text(
                    "Item Dipesan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3C96),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(child: _buildListItem(cart)),

                  Text(
                    "Total: Rp ${cart.totalPrice}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildButtonKonfirmasi(cart),
                ],
              ),
            ),
    );
  }

  // ----------------------------------------------------
  //        WIDGET – DATA PEMESAN
  // ----------------------------------------------------
  Widget _buildDataPemesanBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xFF5C3C96)),
              const SizedBox(width: 12),
              Text(
                "Nama: $namaPemesan",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.chair, color: Color(0xFF5C3C96)),
              const SizedBox(width: 12),
              Text(
                "Meja: $nomorMeja",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  //          WIDGET – LIST ITEM
  // ----------------------------------------------------
  Widget _buildListItem(CartProvider cart) {
    return ListView(
      children: cart.items.entries.map((entry) {
        final MenuModel menu = entry.key;
        final int qty = entry.value;

        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Qty: $qty"),
                ],
              ),
              Text(
                "Rp ${menu.price * qty}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C3C96),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ----------------------------------------------------
  //          WIDGET – TOMBOL KONFIRMASI
  // ----------------------------------------------------
  Widget _buildButtonKonfirmasi(CartProvider cart) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: const Color(0xFF5C3C96),
        ),
        onPressed: () => _handleKonfirmasi(cart),
        child: const Text(
          "Konfirmasi Pesanan",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // ----------------------------------------------------
  //          LOGIC – KONFIRMASI PESANAN
  // ----------------------------------------------------
  Future<void> _handleKonfirmasi(CartProvider cart) async {
    if (cart.items.isEmpty) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Keranjang masih kosong!")));
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pesanan Berhasil!"),
        content: Text(
          "Terima kasih $namaPemesan!\n"
          "Pesanan Anda akan segera diproses.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    cart.clearCart();

    if (!mounted) return;
    Navigator.pop(context);
  }
}
