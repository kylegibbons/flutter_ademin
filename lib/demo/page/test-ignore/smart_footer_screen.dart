import 'package:flutter/material.dart';

class SmartFooterPage extends StatefulWidget {
  const SmartFooterPage({super.key});

  @override
  State<SmartFooterPage> createState() => _SmartFooterPageState();
}

class _SmartFooterPageState extends State<SmartFooterPage> {
  @override
  Widget build(BuildContext context) {
    final footerHeight = 100.0; // Sesuaikan tinggi footer sesuai kebutuhan

    return Scaffold(
      body: Column(
        children: [
          // Konten yang bisa scroll
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Simulasikan konten: ubah jumlah item
                  ...List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text('Item $index'),
                          )),

                  // Spacer di sini akan mengambil sisa ruang
                  Spacer(),

                  // Footer tetap di bawah layar atau di bawah konten
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: footerHeight, // Tentukan tinggi footer di sini
                    child: const Text(
                      'Footer',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
