import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<String> _board;
  late bool _isXTurn;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _board = List<String>.filled(9, '');
      _isXTurn = true;
      _winner = '';
    });
  }

  void _handleTap(int index) {
    if (_board[index] != '' || _winner != '') return;

    setState(() {
      _board[index] = _isXTurn ? 'X' : 'O';
      _isXTurn = !_isXTurn;
      _winner = _checkWinner();
    });
  }

  String _checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] != '' &&
          _board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]]) {
        return _board[pattern[0]];
      }
    }

    if (!_board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(),
          SizedBox(height: 20),
          _buildResultText(),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      shrinkWrap: true,
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultText() {
    return Text(
      _winner.isEmpty ? 'Next turn: ${_isXTurn ? "X" : "O"}' : 'Winner: $_winner',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _resetGame,
      child: Text('Restart Game'),
    );
  }
}
