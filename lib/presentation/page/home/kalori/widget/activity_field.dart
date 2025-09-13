import 'package:flutter/material.dart';

class DropdownActivityField extends StatefulWidget {
  final TextEditingController activityController;
  final ValueChanged<String> onChanged;
  const DropdownActivityField({
    super.key,
    required this.activityController,
    required this.onChanged,
  });

  @override
  State<DropdownActivityField> createState() => _DropdownActivityFieldState();
}

class _DropdownActivityFieldState extends State<DropdownActivityField> {
  final List<String> kategoriAktivitas = [
    "Istirahat total / bedrest",
    "Aktivitas ringan",
    "Aktivitas sedang",
    "Aktivitas berat",
  ];

  final Map<String, String> detailAktivitas = {
    "Istirahat total / bedrest": "Tidur dan Duduk/Bersandar.",
    "Aktivitas ringan":
        "Bekerja duduk saja (didepan komputer/laptop), Ibu Rumah Tangga (Memasak, Menyapu, Menyuci, Menyetrika dll), Menonton TV, Membaca, Jalan santai (<3 km), Mengendarai kendaraan (jarak pendek), Melakukan aktivitas fisik <20 menit.",
    "Aktivitas sedang":
        "Pekerjaan yang memerlukan berdiri lama: guru, dosen, kasir, perawat, penjual, pelayan dll. Jalan kaki >30 menit (jarak 4–6 km), bersepeda santai 30–60 menit, olahraga ringan dan santai (badminton, voli, tenis meja, futsal, senam ringan, basket, sepak takraw, berenang, gym/angkat beban ringan durasi 20–45 menit), ibu rumah tangga aktif.",
    "Aktivitas berat":
        "Pekerja fisik: buruh bangunan, petani, nelayan, jalan cepat/jogging >6 km, olahraga kompetisi >45 menit (senam aerobik, sepakbola, basket, voli, tenis, sepak takraw, gym/angkat beban berat), sepeda sedang-cepat >45 menit.",
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Pilih Aktivitas",
        border: OutlineInputBorder(),
      ),
      initialValue: widget.activityController.text,
      items: kategoriAktivitas.map((kategori) {
        return DropdownMenuItem(value: kategori, child: Text(kategori));
      }).toList(),
      onChanged: (value) {
        setState(() => widget.activityController.text = value ?? '');
        if (value != null) {
          _showDetailBottomSheet(context, value);
          widget.onChanged(value);
        }
      },
    );
  }

  void _showDetailBottomSheet(BuildContext context, String kategori) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Text(
              kategori,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(detailAktivitas[kategori]!),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Tutup"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
