import 'package:flutter/material.dart';

class CustomDrawerPage extends StatefulWidget {
  @override
  _CustomDrawerPageState createState() => _CustomDrawerPageState();
}

class _CustomDrawerPageState extends State<CustomDrawerPage> with SingleTickerProviderStateMixin {
  bool _isDrawerOpen = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      _isDrawerOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Drawer layer
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            left: _isDrawerOpen ? 0 : -MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height,
            child: Material(
              color: Colors.blue,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Text('Header', style: TextStyle(color: Colors.white))),
                  ListTile(title: Text('Item 1', style: TextStyle(color: Colors.white))),
                  ListTile(title: Text('Item 2', style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
          // AppBar and Body layer
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.identity()
              ..translate(_isDrawerOpen ? MediaQuery.of(context).size.width * 0.6 : 0.0)
              ..scale(_isDrawerOpen ? 0.8 : 1.0),
            child: Align(
              alignment: Alignment(0, _isDrawerOpen ? 1.2 : 0), // Adjusted vertical alignment
              child: Container(
                width: _isDrawerOpen ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width,
                height: _isDrawerOpen ? MediaQuery.of(context).size.height * 0.8 : MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_isDrawerOpen ? 30 : 0), // Circular when open
                ),
                child: Column(
                  children: [
                    // Custom AppBar
                    CustomAppBar(onMenuPressed: _toggleDrawer),
                    // Body content
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_isDrawerOpen) _toggleDrawer();
                        },
                        child: Center(child: Text('Drawer Animation Body')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const CustomAppBar({Key? key, required this.onMenuPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // Height of the AppBar
      color: Colors.blue, // AppBar background color
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: onMenuPressed,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Custom Drawer',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
