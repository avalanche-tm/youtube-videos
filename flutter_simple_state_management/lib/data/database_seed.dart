import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedData() async {
  final creds1 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "avalanche@example.com",
    password: "avalanche",
  );
  await creds1.user?.updateDisplayName('Avalanche');

  final creds2 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "avalanche2@example.com",
    password: "avalanche2",
  );
  await creds1.user?.updateDisplayName('Avalanche2');

  final usrSettings = FirebaseFirestore.instance.collection('userSettings');
  await usrSettings.doc(creds1.user!.uid).set({
    'userId': creds1.user!.uid,
    'cartItems': [],
    'boughtItems': [],
  });

  await usrSettings.doc(creds2.user!.uid).set({
    'userId': creds2.user!.uid,
    'cartItems': [],
    'boughtItems': [],
  });

  final items = FirebaseFirestore.instance.collection('items');
  items.doc('1').set({
    'id': '1',
    'name': 'Lightsaber',
    'price': 700,
    'count': 5,
    'imageUrl':
        'https://static.turbosquid.com/Preview/2015/11/28__08_19_48/LukeSkywalkerLightsaber3dmodel02.jpg5099fd3c-58fd-4c2f-95b1-0124eae10089Large.jpg',
    'description': 'Weapon of a Jedi',
  });
  items.doc('2').set({
    'id': '2',
    'name': 'Ring of Power',
    'price': 12000,
    'count': 5,
    'imageUrl':
        'https://canary.contestimg.wish.com/api/webimage/58d87f21d4eba555708e8fdc-large.jpg?cache_buster=251bbd543a234746307808eebd8c0488',
    'description': 'Sauron\'s ring | BUY NOW, PRECIOUS, BUY!',
  });
  items.doc('3').set({
    'id': '3',
    'name': 'Imperial Beskar plates',
    'price': 3000,
    'count': 5,
    'imageUrl':
        'https://www.folkenstal.com/wp-content/uploads/2020/01/Beskar_2.0_double.jpg',
    'description': 'Makes good Mandalorian armor',
  });
  items.doc('4').set({
    'id': '4',
    'name': 'Holy Grail',
    'price': 18000,
    'count': 5,
    'imageUrl':
        'https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTU3ODc4NjAzNTE2NzQ5MTI5/ask-history-what-is-the-holy-grail-2.jpg',
    'description': '*** BREAD NOT INCLUDED ***',
  });
  items.doc('5').set({
    'id': '5',
    'name': 'Arc of the Covenant',
    'price': 17000,
    'count': 5,
    'imageUrl':
        'https://cdn.shopify.com/s/files/1/0134/6232/products/7520_1024x1024.jpg?v=1486485726',
    'description': 'Mighty weapon used to defeat enemies of Izrael',
  });
  items.doc('6').set({
    'id': '6',
    'name': 'Bottled Farts',
    'price': 30,
    'count': 5,
    'imageUrl':
        'https://scontent-frt3-1.xx.fbcdn.net/v/t1.6435-9/69713650_2391629187777794_4971614907876245504_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEub9KxGYcvLU44Tyx0uRpVslmjC7K75CqyWaMLsrvkKu6FyYo6A2c0k9zhBYtALOyJCBxQS9evWuf-Byv6QR4Z&_nc_ohc=dWHBx8GtcbUAX_pH7jJ&_nc_ht=scontent-frt3-1.xx&oh=00_AT-_Ez98Av6mFBpHu34bTqoGRLTiSYw5VO0m4eehiPpLEw&oe=6234477E',
    'description': 'Don\'t ask...',
  });
}
