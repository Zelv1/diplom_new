import 'package:flutter/material.dart';

class ProductSelectionWidget extends StatefulWidget {
  final List<String> products;
  final Function(String, int) onProductAdded;

  const ProductSelectionWidget({
    super.key,
    required this.products,
    required this.onProductAdded,
  });

  @override
  _ProductSelectionWidgetState createState() => _ProductSelectionWidgetState();
}

class _ProductSelectionWidgetState extends State<ProductSelectionWidget> {
  String? _selectedProduct;
  int _quantity = 1;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '$_quantity');
    _quantityController.addListener(_onQuantityChanged);
  }

  @override
  void dispose() {
    _quantityController.removeListener(_onQuantityChanged);
    _quantityController.dispose();
    super.dispose();
  }

  void _onQuantityChanged() {
    setState(() {
      _quantity = int.tryParse(_quantityController.text) ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _selectedProduct,
            onChanged: (String? value) {
              setState(() {
                _selectedProduct = value;
              });
            },
            items: widget.products.map((String product) {
              return DropdownMenuItem<String>(
                value: product,
                child: Text(product),
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity = (_quantity > 1) ? _quantity - 1 : 1;
                    _quantityController.text = '$_quantity';
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              IntrinsicWidth(
                child: TextFormField(
                  minLines: null,
                  maxLines: 1,
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                    _quantityController.text = '$_quantity';
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 30, 30, 30),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 30, 30, 30),
              ),
              onPressed: () {
                if (_selectedProduct != null) {
                  widget.onProductAdded(_selectedProduct!, _quantity);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Добавить',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderFormWidget extends StatefulWidget {
  const OrderFormWidget({super.key});

  @override
  _OrderFormWidgetState createState() => _OrderFormWidgetState();
}

class _OrderFormWidgetState extends State<OrderFormWidget> {
  final List<String> _products = ['Product 1', 'Product 2', 'Product 3'];
  final Map<String, int> _selectedProducts = {};

  String? _address;
  String? _comments;

  void _showProductSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Выбрать товар',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 30, 30, 30),
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ProductSelectionWidget(
              products: _products,
              onProductAdded: (String product, int quantity) {
                setState(() {
                  if (_selectedProducts.containsKey(product)) {
                    _selectedProducts[product] =
                        (_selectedProducts[product] ?? 0) + quantity;
                  } else {
                    _selectedProducts[product] = quantity;
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: OrderFormFields(context),
            ),
            PublishOrderButton(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView OrderFormFields(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                _address = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Укажите адрес',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 30, 30, 30),
            ),
            child: ElevatedButton(
              onPressed: _showProductSelectionDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 30, 30, 30),
              ),
              child: const Text(
                'Выбрать товар',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Text(
            'Выбранные товары:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color.fromARGB(255, 30, 30, 30),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _selectedProducts.length,
            itemBuilder: (BuildContext context, int index) {
              final productName = _selectedProducts.keys.elementAt(index);
              final quantity = _selectedProducts[productName];
              return ListTile(
                title: Text('$productName x $quantity'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _selectedProducts.remove(productName);
                    });
                  },
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _comments = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Комментарий',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }

  Container PublishOrderButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          print('Selected Products: $_selectedProducts');
          print('Address: $_address');
          print('Comments: $_comments');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        ),
        child: const Text(
          'Опубликовать',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
