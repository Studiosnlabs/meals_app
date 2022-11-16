//@dart=2.9
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters-screen';
  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FilterScreen(this.currentFilters,this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  initState(){
    _glutenFree= widget.currentFilters['gluten'];
    _lactosefree= widget.currentFilters['lactose'];
    _vegeterian= widget.currentFilters['vegetarian'];
    _vegan= widget.currentFilters['vegan'];

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  final selectedFilters={
                    'gluten': _glutenFree,
                    'lactose': _vegeterian,
                    'vegan': _vegan,
                    'vegetarian': _lactosefree,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                      "Gluten Free",
                      "Includes only gluten free meals",
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      "Vegetarian",
                      "Includes only vegetarian meals",
                      _vegeterian, (newValue) {
                    setState(() {
                      _vegeterian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      "Vegan", "Includes only vegan meals", _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      "Lactose-free",
                      "Includes only lactose-free meals",
                      _lactosefree, (newValue) {
                    setState(() {
                      _lactosefree = newValue;
                    });
                  })
                ],
              ),
            )
          ],
        ));
  }
}
