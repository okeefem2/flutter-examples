import 'package:flutter/material.dart';

class ShowChart extends StatelessWidget {
  const ShowChart({
    Key key,
    @required bool showChart,
    @required Function toggleShowChart,
  })  : _showChart = showChart,
        _toggleShowChart = toggleShowChart,
        super(key: key);

  final bool _showChart;
  final Function _toggleShowChart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart', style: Theme.of(context).textTheme.title),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          onChanged: _toggleShowChart,
          value: _showChart,
        ),
      ],
    );
  }
}
