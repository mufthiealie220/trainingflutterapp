import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _currentIndex = 0;
  var namauser = '';
  final TextEditingController _inputController = TextEditingController();
  List<String> _savedData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = (prefs.getString('username') ?? '');
      _savedData = prefs.getStringList('savedData') ?? [];
    });
  }

  void _saveData() async {
    if (_inputController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _savedData.add(_inputController.text);
      await prefs.setStringList('savedData', _savedData);
      _inputController.clear();
      setState(() {});
    }
  }

  void _deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedData.removeAt(index);
    await prefs.setStringList('savedData', _savedData);
    setState(() {});
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Widget _buildHome() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat datang, $namauser',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Total data tersimpan: ${_savedData.length}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _inputController,
            decoration: InputDecoration(
              hintText: 'Masukkan data',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _saveData,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    return _savedData.isEmpty
        ? const Center(child: Text('Tidak ada data tersimpan'))
        : ListView.builder(
            itemCount: _savedData.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(_savedData[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteData(index),
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildHome(),
      _buildInput(),
      _buildDataList(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔥 Hilangkan tombol back
        elevation: 0,

        title: Row(
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(), // 🔥 Dorong icon logout ke kanan

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Apakah Anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Batal'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () {
                            _logout();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.logout,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),

      body: pages[_currentIndex],

      // 🎯 BOTTOM MENU MODERN
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,

            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 28),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, size: 30),
                label: 'Input',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt, size: 28),
                label: 'Data',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
