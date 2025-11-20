import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FD),
      appBar: AppBar(
        title: const Text(
          "Profil & Informasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFB891F9),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "FoodByNagit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3C96),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Pasti Bikin Balik Lagi!",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _sectionTitle("Informasi Restoran"),
            _infoTile(
              Icons.location_on,
              "Lokasi",
              "Cikumapay, Campaka, Purwakarta",
            ),
            _infoTile(Icons.access_time, "Jam Buka", "10.00 - 22.00 WIB"),
            _infoTile(Icons.phone, "Telepon", "0895-3928-94145"),
            _infoTile(Icons.star, "Rating", "4.8 / 5.0"),

            const SizedBox(height: 30),
            _sectionTitle("Tentang Aplikasi"),
            _infoTile(Icons.phone_android, "Versi Aplikasi", "v1.0.0"),
            _infoTile(Icons.code, "Dikembangkan oleh", "Nazwa Akmalul Firdaus"),

            const SizedBox(height: 40),
            Center(
              child: Text(
                "Terima kasih sudah berkunjung! ❤️",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5C3C96),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF5C3C96)),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(value, style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
