import 'package:flutter/material.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({Key? key});

  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  TextEditingController _organizationController = TextEditingController();
  String _originalOrganization =
      "ООО Пивной дзен"; 
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _organizationController.text = _originalOrganization;
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _organizationController.text = _originalOrganization;
      }
    });
  }

  void _saveChanges() {
    setState(() {
      _originalOrganization = _organizationController.text;
      _isEditing = false;
    });
    // Implement logic to save changes to backend
  }

  void _cancelChanges() {
    setState(() {
      _isEditing = false;
      _organizationController.text = _originalOrganization;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(radius: 50),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _isEditing
                        ? IntrinsicWidth(
                            child: TextFormField(
                              minLines: null,
                              maxLines: 1,
                              controller: _organizationController,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          )
                        : Text(
                            _originalOrganization,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Редактировать профиль',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      trailing: _isEditing
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: _saveChanges,
                                  icon: const Icon(Icons.check_circle),
                                ),
                                IconButton(
                                  onPressed: _cancelChanges,
                                  icon: const Icon(Icons.cancel),
                                ),
                              ],
                            )
                          : const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        setState(() {
                          _isEditing = !_isEditing;
                          if (!_isEditing) {
                            _organizationController.text =
                                _originalOrganization;
                          }
                        });
                      },
                    ),
                    const Divider(color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Изменить адрес',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Изменить пароль',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 228, 228),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Выйти из аккаунта',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
