import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Initiate Calculator App and set theme
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      //For Light Mode
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          shadowColor: Colors.grey.shade200,
          cardColor: Colors.grey.shade50,
          buttonColor: Colors.grey

        /* light theme settings */
      ),
      //For Dark Mode
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey.shade800,
          shadowColor: Colors.black45,
          cardColor: Colors.grey.shade700,
          buttonColor: Colors.white
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var firstOperand = '';
  var secondOperand = '';
  var operator = '';
  var result = '';
  var total = '';
  var prevOp = '';
  var inputInst = '';

  void onButtonTapped(String label) {
     print(label);
    switch (label) {
      case 'AC':
        clearAll();
        break;
      case '+':
      case '-':
      case '/':
      case 'x':
      operatorClicked(label);
      break;
      case '%':
        onPercentClicked();
        break;
      case '+/-':
        addSub();
        break;
      case '.':
        decimalClicked();
        break;
      case '=':
        evaluateExpression();
        break;
      default:
        numberClicked(label);
        break;
    }
  }

  void numberClicked(String label) {
    if (firstOperand == '') {
      setState(() {
        firstOperand = label;
        result = firstOperand;
      });
      return;
    }
    if (firstOperand != '' && operator == '') {
      setState(() {
        firstOperand += label;
        result = firstOperand;
      });
      return;
    }
    if (firstOperand != '' && secondOperand == '') {
      setState(() {
        secondOperand = label;
        result = secondOperand;
      });
      return;
    }
    if (firstOperand != '' && operator != '' && secondOperand != '') {
      setState(() {
        secondOperand += label;
        result = secondOperand;
      });
      return;
    }
  }

  void operatorClicked(String label) {
    if (firstOperand != '' && secondOperand=='') operator = label;
    setState(() {});
  }

  void clearAll() {
    setState(() {
      inputInst='';
      firstOperand = '';
      secondOperand = '';
      operator = '';
      result = '';
      total = '';
    });
  }

  void evaluateExpression() {
    if (firstOperand.contains('Infinity')) {
      total = 'Infinity';
      setValue();
      return;
    }

    if (firstOperand.startsWith('-')) {
      prevOp = '-';
      firstOperand = firstOperand.substring(1);
    }
    else {
      prevOp = '';
    }

    switch (operator) {
      case '+':
        add();
        break;
      case '-':
        subtract();
        break;
      case 'x':
        multiply();
        break;
      case '/':
        divide();
        break;
      // case '%':
      //   mod();
      //   break;
    }
  }

  void decimalClicked() {
    if (firstOperand.contains('.')) return;
    if (firstOperand == '') {
      firstOperand = '0.';
    } else {
      firstOperand += '.';
    }
    result = firstOperand;
    setState(() {

    });
  }

  void add() {
    if (firstOperand.contains('.') || secondOperand.contains('.')) {
      total = prevOp != ''
          ? (-double.parse(firstOperand) + double.parse(secondOperand)).toStringAsFixed(2)
          .toString()
          : (double.parse(firstOperand) + double.parse(secondOperand)).toStringAsFixed(2)
          .toString();
    } else {
      total = prevOp != ''
          ? ((-int.parse(firstOperand) + int.parse(secondOperand)).toString())
          : ((int.parse(firstOperand) + int.parse(secondOperand)).toString());
    }

    setValue();

    print('1:$firstOperand');
    print('2:$secondOperand');
    print('op:$operator');
  }

  void subtract() {
    if (firstOperand.contains('.') || secondOperand.contains('.')) {
      total = prevOp != ''
          ? (-double.parse(firstOperand) - double.parse(secondOperand)).toStringAsFixed(2)
          .toString()
          : (double.parse(firstOperand) - double.parse(secondOperand)).toStringAsFixed(2)
          .toString();
    } else {
      total = prevOp != ''
          ? (-int.parse(firstOperand) - int.parse(secondOperand)).toString()
          : (int.parse(firstOperand) - int.parse(secondOperand)).toString();
      ;
    }

    setValue();

    print('1:$firstOperand');
    print('2:$secondOperand');
    print('op:$operator');
  }

  void multiply() {
    if (firstOperand.contains('.') || secondOperand.contains('.')) {
      total = prevOp != ''
          ? (-double.parse(firstOperand) * double.parse(secondOperand)).toStringAsFixed(2)
          .toString()
          : (double.parse(firstOperand) * double.parse(secondOperand)).toStringAsFixed(2)
          .toString();
    } else {
      total = prevOp != ''
          ? (-int.parse(firstOperand) * int.parse(secondOperand)).toString()
          : (int.parse(firstOperand) * int.parse(secondOperand)).toString();
    }

    setValue();

    print('1:$firstOperand');
    print('2:$secondOperand');
    print('op:$operator');
  }

  void divide() {
    if (secondOperand != '' && (secondOperand == 0 || secondOperand == 0.0)) {
      total = 'Infinity';
      setValue();

      return;
    }
    if (firstOperand.contains('.') || secondOperand.contains('.')) {
      total = prevOp != ''
          ? (-double.parse(firstOperand) / double.parse(secondOperand)).toStringAsFixed(2)
          .toString()
          : (double.parse(firstOperand) / double.parse(secondOperand)).toStringAsFixed(2)
          .toString();
    } else {
      total = prevOp != ''
          ? (-int.parse(firstOperand) / int.parse(secondOperand)).toString()
          : (int.parse(firstOperand) / int.parse(secondOperand)).toString();
    }

    setValue();

    print('1:$firstOperand');
    print('2:$secondOperand');
    print('op:$operator');
  }

  void mod() {
    if (firstOperand.contains('.') || secondOperand.contains('.')) {
      total = prevOp != ''
          ? (-double.parse(firstOperand) % double.parse(secondOperand)).toStringAsFixed(2)
          .toString()
          : (double.parse(firstOperand) % double.parse(secondOperand)).toStringAsFixed(2)
          .toString();
    } else {
      total = prevOp != ''
          ? (-int.parse(firstOperand) % int.parse(secondOperand)).toString()
          : (int.parse(firstOperand) % int.parse(secondOperand)).toString();
    }
    setValue();

    print('1:$firstOperand');
    print('2:$secondOperand');
    print('op:$operator');
  }

  void setValue() {
    setState(() {
      inputInst = firstOperand + operator + secondOperand;
      result = total;
      firstOperand = total;
      secondOperand = '';
      operator = '';
      total = '';
    });
  }

  void addSub() {
    if (firstOperand != '') {
      if (firstOperand.startsWith('-')) {
        total = firstOperand.substring(1);
        setValue();
      } else {
        total = '-' + firstOperand;
        setValue();
      }
    }
  }

  void onPercentClicked(){
    if(firstOperand!='' && secondOperand=='') {
      firstOperand = (prevOp != ''
          ? (-double.parse(firstOperand) * 1 / 100).toStringAsFixed(2)
          : (double.parse(firstOperand) * 1 / 100).toStringAsFixed(2)).toString();
      total=firstOperand;
    }
    else if(firstOperand!='' && secondOperand!='') {
      secondOperand = (prevOp != ''
          ? (-double.parse(secondOperand) * 1 / 100).toStringAsFixed(2)
          : (double.parse(secondOperand) * 1 / 100).toStringAsFixed(2)).toString();
      total=secondOperand;
    }
    setValue();
  }

  //Root Widget for calculator
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            //Input/Result Field
            Expanded(flex: 3, child: InputAndResultField(inst:inputInst,result: result)),
            Expanded(
              flex: 7,
              child: ButtonsFields(onTap: onButtonTapped),
            ),
          ]),
        ),
      ),
    );
  }
}

class InputAndResultField extends StatelessWidget {
  final result;
  final inst;

  const InputAndResultField({this.inst,this.result});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                inst,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.orange.shade600),
              ),
              Text(
                result,
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonsFields extends StatelessWidget {
  final Function(String) onTap;

  const ButtonsFields({required this.onTap});

//Widget for button fields
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonsRow(index: 1, onTap: onTap),
        ButtonsRow(index: 2, onTap: onTap),
        ButtonsRow(index: 3, onTap: onTap),
        ButtonsRow(index: 4, onTap: onTap),
        ButtonsRow(index: 5, onTap: onTap),
      ],
    );
  }
}

class ButtonsRow extends StatelessWidget {
  final int index;
  final Function(String) onTap;

  const ButtonsRow({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    switch (index) {
    //First Row
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: 'AC', onTap: onTap),
            Button(label: '+/-', onTap: onTap),
            Button(label: '%', onTap: onTap),
            Button(label: '/', onTap: onTap),
          ],
        );
    //Second Row
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: '7', onTap: onTap),
            Button(label: '8', onTap: onTap),
            Button(label: '9', onTap: onTap),
            Button(label: 'x', onTap: onTap),
          ],
        );
    //Third Row
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: '6', onTap: onTap),
            Button(label: '5', onTap: onTap),
            Button(label: '4', onTap: onTap),
            Button(label: '-', onTap: onTap),
          ],
        );
    //Fourth Row
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: '3', onTap: onTap),
            Button(label: '2', onTap: onTap),
            Button(label: '1', onTap: onTap),
            Button(label: '+', onTap: onTap),
          ],
        );
    //Fifth Row
      case 5:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: '0', onTap: onTap),
            Button(label: '.', onTap: onTap),
            Button(label: '=', onTap: onTap),
          ],
        );
    }
    return this;
  }
}

class Button extends StatelessWidget {
  final label;
  final Function(String) onTap;

  const Button({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Ink(
      width: label == '0' ? (MediaQuery
          .of(context)
          .size
          .width / 2) - 40 : 70,
      height: 70,
      decoration: BoxDecoration(
        // color: !isDarkMode ? Colors.white : Colors.grey.shade800,
        color: Theme
            .of(context)
            .primaryColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            // color: !isDarkMode ? Colors.grey.shade200 : Colors.black45,
            color: Theme
                .of(context)
                .shadowColor,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
          BoxShadow(
            // color: !isDarkMode ? Colors.grey.shade50 : Colors.grey.shade700,
            color: Theme
                .of(context)
                .cardColor,
            blurRadius: 5,
            offset: Offset(-3, -3), // changes position of shadow
          ),
        ],
        /* gradient: label == '0'
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.99],
                  colors: [
                    !isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
                    !isDarkMode ? Colors.white70 : Colors.grey.shade700
                  ],
                )
              : null*/
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(35),
        onTap: () => {onTap(label)},
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Align(
              alignment: label == '0' ? Alignment.centerLeft : Alignment.center,
              child: Text(label,
                  style: TextStyle(
                      fontSize: 20,
                      color: getFontColor(label, context),
                      fontWeight: FontWeight.w300))),
        ),
      ),
    );
  }

  //Get Font Color on the basis of type i.e. number or operator
  Color getFontColor(String label, BuildContext context) {
    if (label == 'AC' || label == '%' || label == '+/-')
      return Colors.grey.shade400;
    else if (label == '+' || label == '-' || label == '/' || label == 'x')
      return Colors.orange.shade600;
    return Theme
        .of(context)
        .buttonColor;
  }


}

