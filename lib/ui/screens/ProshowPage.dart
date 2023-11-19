import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/proshow/bloc/proshow_bloc.dart';

class ProshowPage extends StatelessWidget {
  const ProshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: ProshowBloc()..add(ProshowInit()),
        builder: (BuildContext context, state) {
          if (state is ProshowLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProshowLoaded) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      state.data[index].url,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 50,
                      child: Text(
                        state.data[index].name,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    Positioned(
                        bottom: 50,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ElevatedButton(
                              child: const Text("Register"),
                              onPressed: () {},
                            ),
                          ),
                        ))
                  ]),
                );
              },
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }
}
