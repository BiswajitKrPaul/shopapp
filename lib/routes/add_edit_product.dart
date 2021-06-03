import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
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
