import 'package:calculator_001/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userQuestion = '';
  String userAnswer = '';

  final myTextStyle =
      TextStyle(fontSize: 30, color: Colors.deepPurple.shade900);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return ButtonsWidget(
                        color: Colors.green,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '0,00';
                          });
                        },
                        fontSize: 20,
                        borderRadius: 20,
                      );
                    }
                    // delete button
                    else if (index == 1) {
                      return ButtonsWidget(
                        color: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            if (userQuestion.isNotEmpty) {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            }
                          });
                        },
                        fontSize: 20,
                        borderRadius: 20,
                      );
                    }
                    // Equal button
                    else if (index == buttons.length - 1) {
                      return ButtonsWidget(
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        fontSize: 20,
                        borderRadius: 20,
                      );
                    }
                    // ANS button
                    else if (index == buttons.length - 2) {
                      return ButtonsWidget(
                        color: Colors.orange,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            userQuestion += userAnswer;
                          });
                        },
                        fontSize: 20,
                        borderRadius: 20,
                      );
                    }
                    // Rest of Button
                    else {
                      return ButtonsWidget(
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple.shade200,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple.shade900,
                        buttonText: buttons[index],
                        buttonTapped: () {
                          setState(() {
                            // Evita operadores consecutivos
                            if (userQuestion.isNotEmpty &&
                                isOperator(buttons[index]) &&
                                isOperator(
                                    userQuestion[userQuestion.length - 1])) {
                              userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1) +
                                  buttons[index];
                            } else {
                              userQuestion += buttons[index];
                            }
                          });

                          // setState(() {
                          //   if (userQuestion.isEmpty ||
                          //       !isOperator(
                          //           userQuestion[userQuestion.length - 1])) {
                          //     userQuestion += buttons[index];
                          //   }
                          // });

                          // setState(() {
                          //   userQuestion += buttons[index];
                          // });
                        },
                        fontSize: 20,
                        borderRadius: 20,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String X) {
    const operadores = {'%', '/', 'X', '-', '+', '='};
    return operadores.contains(X);
  }

  // bool isOperator(String X) {
  //   if (X == '%' || X == '/' || X == 'X' || X == '-' || X == '+' || X == '=') {
  //     return true;
  //   }
  //   return false;
  // }

  void equalPressed() {
    if (userQuestion.isEmpty ||
        isOperator(userQuestion[userQuestion.length - 1])) {
      userAnswer = "Expressão Inválida";
      return;
    }
    try {
      String finalQuestion = userQuestion.replaceAll('X', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      userAnswer = eval.isInfinite || eval.isNaN
          ? "Erro (divisão por 0)"
          : eval.toStringAsFixed(2);
    } catch (e) {
      userAnswer = "Erro";
    }
  }

  // void equalPressed() {
  //   try {
  //     String finalQuestion = userQuestion.replaceAll('X', '*');

  //     Parser p = Parser();
  //     Expression exp = p.parse(finalQuestion);
  //     ContextModel cm = ContextModel();

  //     double eval = exp.evaluate(EvaluationType.REAL, cm);
  //     if (eval.isInfinite || eval.isNaN) {
  //       userAnswer = "Erro (divisão por 0)";
  //     } else {
  //       userAnswer = eval.toStringAsFixed(2);
  //     }
  //     // if (eval.isInfinite) {
  //     //   userAnswer = "Erro (divisão por 0)";
  //     // } else {
  //     //   userAnswer = eval.toStringAsFixed(2);
  //     // }
  //   } catch (e) {
  //     userAnswer = "Erro";
  //   }
  // }

  // void equalPressed() {
  //   String finalQuestion = userQuestion;
  //   finalQuestion = finalQuestion.replaceAll('X', '*');

  //   Parser p = Parser();
  //   Expression exp = p.parse(finalQuestion);
  //   ContextModel cm = ContextModel();
  //   double eval = exp.evaluate(EvaluationType.REAL, cm);

  //   userAnswer = eval.toString();
  // }
}
