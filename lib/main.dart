import 'package:flutter/material.dart';
void main() => runApp(const FasilitasKesehatanApp());
class FasilitasKesehatan {
  final String nama;
  final String alamat;
  final String nomorDarurat;
  final bool igdBuka;
  final int sisaBed;

  const FasilitasKesehatan({
    required this.nama,
    required this.alamat,
    required this.nomorDarurat,
    required this.igdBuka,
    required this.sisaBed,
  });
}

const List<FasilitasKesehatan> daftarFasilitas = [
  FasilitasKesehatan(
    nama: 'RSUD Kota Bandung',
    alamat: 'Jl. Rumah Sakit No. 22',
    nomorDarurat: '022-0000001',
    igdBuka: true,
    sisaBed: 14,
  ),
  FasilitasKesehatan(
    nama: 'RS Hasan Sadikin Bandung',
    alamat: 'Jl. Pasteur No. 38',
    nomorDarurat: '022-0000002',
    igdBuka: true,
    sisaBed: 5,
  ),
  FasilitasKesehatan(
    nama: 'Puskesmas Pasirkaliki',
    alamat: 'Jl. Pasirkaliki No. 120',
    nomorDarurat: '022-0000003',
    igdBuka: false,
    sisaBed: 0,
  ),
  FasilitasKesehatan(
    nama: 'Puskesmas Sukajadi',
    alamat: 'Jl. Sukajadi No. 102',
    nomorDarurat: '022-0000004',
    igdBuka: true,
    sisaBed: 2,
  ),
];

class FasilitasKesehatanApp extends StatelessWidget {
  const FasilitasKesehatanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fasilitas Kesehatan Siaga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HalamanFasilitas(),
    );
  }
}

class HalamanFasilitas extends StatelessWidget {
  const HalamanFasilitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          'Fasilitas Kesehatan Kota Bandung',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarFasilitas.length,
        itemBuilder: (context, index) {
          return KartuFasilitas(data: daftarFasilitas[index]);
        },
      ),
    );
  }
}

class KartuFasilitas extends StatelessWidget {
  final FasilitasKesehatan data;

  const KartuFasilitas({super.key, required this.data});

  void _hubungi(BuildContext context) {
    print('Menghubungi ${data.nama} di ${data.nomorDarurat}...');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Menghubungi ${data.nama} (${data.nomorDarurat})')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color warnaUtama = data.igdBuka ? Colors.teal : Colors.red;
    final Color latarBadge =
        data.igdBuka ? Colors.green.shade100 : Colors.red.shade100;
    final Color teksBadge =
        data.igdBuka ? Colors.green.shade900 : Colors.red.shade900;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        isThreeLine: true,
        onTap: () => print('Membuka detail ${data.nama}'),
        leading: CircleAvatar(
          backgroundColor: warnaUtama.withOpacity(0.12),
          child: Icon(Icons.add_box, color: warnaUtama),
        ),
        title: Text(
          data.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(data.alamat),
            const SizedBox(height: 6),
            Row(
              children: [
                // Indikator visual status IGD
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: latarBadge,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.igdBuka ? 'IGD BUKA' : 'IGD TUTUP',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: teksBadge,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Sisa Bed: ${data.sisaBed}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        data.igdBuka ? FontWeight.normal : FontWeight.bold,
                    color: data.igdBuka ? Colors.black87 : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.phone_in_talk, color: Colors.blue),
          tooltip: 'Hubungi IGD',
          onPressed: () => _hubungi(context),
        ),
      ),
    );
  }
}