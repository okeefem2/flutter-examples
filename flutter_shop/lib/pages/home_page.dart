import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/product_overview_page.dart';
import 'package:provider/provider.dart';

import 'auth_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return user != null ? ProductOverviewPage() : AuthPage();
  }
}
