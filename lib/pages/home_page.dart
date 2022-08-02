import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/blocs/internet_bloc/internet_bloc.dart';

import '../blocs/internet_bloc/internet_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            // BlocBuilder - Builds a UI
            // BlocListener - Just Listens and performs a tasks on state changed
            // BlocConsumer - Combination of both
            child: BlocConsumer<InternetBloc, InternetState>(
                //InternetBloc == InternetCubit
                builder: (context, state) {
          if (state is InternetGainedState) {
            return Text('Connected');
          } else if (state is InternetLostState) {
            return Text('Lost');
          } else {
            return Text('Loading...');
          }
        }, listener: ((context, state) {
          if (state is InternetGainedState) {
            // InternetGainedState = InternetState.Gained
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Connected')));
          } else if (state is InternetLostState) {
            // InternetGainedState = InternetState.Lost
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Lost')));
          }
        }))

            //  BlocBuilder<InternetBloc, InternetState>(
            //     builder: (context, state) {
            //   if (state is InternetGainedState) {
            //     return Text('Connected');
            //   } else if (state is InternetLostState) {
            //     return Text('Lost');
            //   } else {
            //     return Text('Loading...');
            //   }
            // }),
            ),
      ),
    );
  }
}
