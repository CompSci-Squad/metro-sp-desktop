import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/services/apiService.dart';
import '../shared/global/globalVariables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _dataFuture;

  Future<Map<String, dynamic>> fetchData(String userEmail) async {
    final response = await apiService.get('/user/$userEmail');
    return response;
  }

  @override
  void initState() {
    super.initState();
    final userEmail =
        Provider.of<GlobalVariables>(context, listen: false).user?["email"];
    _dataFuture = fetchData(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.asset(
                        'assets/barraMetro.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    _buildHeader(context), 
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildProfileImage(),
                            const SizedBox(height: 20),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 400),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildProfileItem(
                                      "Número de registro", data["id"]),
                                  _buildThickerDivider(),
                                  _buildProfileItem(
                                      "Email @metro", data["email"]),
                                  _buildThickerDivider(),
                                  _buildProfileItem(
                                      "Estação", data["stations"][0]["name"]),
                                  _buildThickerDivider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data found'));
              }
            }));
  }

  Widget _buildHeader(BuildContext context) {
    final userName =
        Provider.of<GlobalVariables>(context, listen: false).user?["name"];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
          Text(
            'Olá $userName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 80, 
      backgroundColor: Colors.grey[300],
      child: const Icon(
        Icons.person,
        size: 100, 
        color: Colors.black54,
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6), 
          Text(
            value,
            style: const TextStyle(
              fontSize: 18, 
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }
}
