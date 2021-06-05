import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/providers/product_list_provider.dart';

class AddEditProduct extends StatefulWidget {
  static const String routeName = '/AddEditProduct';
  const AddEditProduct({Key key}) : super(key: key);

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  Product newProduct = Product(
    id: null,
    description: '',
    imageUrl: '',
    price: 0,
    title: '',
  );

  @override
  void initState() {
    super.initState();
    _imageFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    _imageFocus.removeListener(updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocus.dispose();
    super.dispose();
  }

  void updateImage() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      newProduct.setFav();
      Provider.of<ProductList>(context, listen: false).addProduct(newProduct);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Saved'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: (value) {
                    newProduct = Product(
                      id: null,
                      description: newProduct.description,
                      imageUrl: newProduct.imageUrl,
                      price: newProduct.price,
                      title: value,
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Title can\'t be blank.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: (value) {
                    newProduct = Product(
                      id: null,
                      description: newProduct.description,
                      imageUrl: newProduct.imageUrl,
                      price: double.parse(value),
                      title: newProduct.title,
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Price can\'t be blank.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Price can only be number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Price should be greater than zero';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    newProduct = Product(
                      id: null,
                      description: value,
                      imageUrl: newProduct.imageUrl,
                      price: newProduct.price,
                      title: newProduct.title,
                    );
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Description can\'t be blank.';
                    }
                    if (value.length < 10) {
                      return 'Description should be atleast 10 characters long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter Image URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.contain,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageFocus,
                        onFieldSubmitted: (val) => _saveForm(),
                        onSaved: (value) {
                          newProduct = Product(
                            id: DateTime.now().toString(),
                            description: newProduct.description,
                            imageUrl: value,
                            price: newProduct.price,
                            title: newProduct.title,
                            isFaourite: false,
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
