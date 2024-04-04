import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BreadBot user app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(children: [
          const Text("Welcome to Breadbot sandwich making machine"),
          ElevatedButton(
              onPressed: () {
                print("Button pressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OptionsPage()),
                );
              },
              child: const Text("Create Order")),
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Page with options of saved sandwich or new sandwich.
class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Build sandwich from:"),
          ElevatedButton(
            child: const Text('Saved Orders'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedOptions()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('New Order'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BreadChoices()),
              );
            },
          ),
        ]),
      ),
    );
  }
}

// Page to choose from saved sandwich orders
class SavedOptions extends StatelessWidget {
  const SavedOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(children: [
        Text("Saved options page"),
        Text("Not implemented yet"),
      ]),
    );
  }
}

// Page to choose bread choice

enum Bread {
  white('White'),
  multi('Multigrain'),
  rye('Rye');

  const Bread(this.type);
  final String type;
}

class BreadChoices extends StatelessWidget {
  BreadChoices({super.key});
  final TextEditingController breadChoiceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenu<Bread>(
                initialSelection: Bread.white,
                controller: breadChoiceController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Bread choice'),
                onSelected: (Bread? bread) {
                  print("Chose ${bread?.type}");
                },
                dropdownMenuEntries:
                    Bread.values.map<DropdownMenuEntry<Bread>>((Bread bread) {
                  return DropdownMenuEntry<Bread>(
                    value: bread,
                    label: bread.type,
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              child: const Text('Confirm bread choice'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToppingsChoices()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum Topping {
  pepperjack('Pepper Jack'),
  cheddar('Cheddar'),
  noCheese('No Cheese'),
  turkey('turkey'),
  chicken('chicken'),
  pastrami('pastrami'),
  seitan('Seitan'),
  beyondMeat('Beyond Meat'),
  noMeat('No Meat'),
  tomato('Tomato'),
  cucumber('Cucumber'),
  springMix('Spring mix'),
  lettuce('Lettuce'),
  onion('Onion'),
  noToppings('No Toppings');

  const Topping(this.type);
  final String type;
}

class ToppingsChoices extends StatelessWidget {
  ToppingsChoices({super.key});

  final MultiSelectController<Topping> multiSelectController = MultiSelectController();

  final List<ValueItem> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            /*DropdownMenu<Cheese>(
              initialSelection: Cheese.noCheese,
              controller: cheeseChoiceController,
              requestFocusOnTap: true,
              label: const Text('Cheese choice'),
              onSelected: (Cheese? cheese) {
                print("Chose ${cheese?.type}");
              },
              dropdownMenuEntries:
                  Cheese.values.map<DropdownMenuEntry<Cheese>>((Cheese cheese) {
                return DropdownMenuEntry<Cheese>(
                  value: cheese,
                  label: cheese.type,
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownMenu<Meat>(
              initialSelection: Meat.noMeat,
              controller: meatChoiceController,
              requestFocusOnTap: true,
              label: const Text('Meat choice'),
              onSelected: (Meat? meat) {
                print("Chose ${meat?.type}");
              },
              dropdownMenuEntries:
                  Meat.values.map<DropdownMenuEntry<Meat>>((Meat meat) {
                return DropdownMenuEntry<Meat>(
                  value: meat,
                  label: meat.type,
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownMenu<Veggies>(
              initialSelection: Veggies.noToppings,
              controller: veggieChoiceController,
              requestFocusOnTap: true,
              label: const Text('Vegetable choice'),
              onSelected: (Veggies? veggie) {
                print("Chose ${veggie?.type}");
              },
              dropdownMenuEntries: Veggies.values
                  .map<DropdownMenuEntry<Veggies>>((Veggies veggie) {
                return DropdownMenuEntry<Veggies>(
                  value: veggie,
                  label: veggie.type,
                );
              }).toList(),
            ),*/


            MultiSelectDropDown<Topping> (
                    controller: multiSelectController,
                    onOptionSelected: (options) {},
                    options: Topping.values.map<ValueItem<Topping>>((Topping topping) {
                      return ValueItem<Topping>(
                        value: topping,
                        label: topping.type,
                      ); }).toList(),
                    maxItems: 10,
                    singleSelectItemStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    chipConfig: const ChipConfig(
                        wrapType: WrapType.wrap, backgroundColor: Colors.red),
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(
                      Icons.check_circle,
                      color: Colors.pink,
                    ),
                    selectedOptionBackgroundColor: Colors.grey.shade300,
                    selectedOptionTextColor: Colors.blue,
                    dropdownMargin: 2,
                    onOptionRemoved: (index, option) {},
                    optionBuilder: (context, valueItem, isSelected) {
                      return ListTile(
                        title: Text(valueItem.label),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.radio_button_unchecked),
                      );
                    }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('comfirm toppings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderConfirmation()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});
//back to start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Confirm Order'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Thankyou()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Add More'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OptionsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Thankyou extends StatelessWidget {
  const Thankyou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text('Thank you'),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ),
    );
  }
}
