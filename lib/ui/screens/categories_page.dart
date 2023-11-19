import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/config/constants/constants.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';
import '../../logic/router.dart';
import '../widgets/category_tile.dart';
import '../../logic/blocs/categories/bloc/categories_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoriesPage extends StatelessWidget {
  final RevelsAppState appState;
  const CategoriesPage({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesBloc>().add(FetchCategoriesEvent());
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          'Categories',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return loading(context);
          }
          if (state is CategoriesLoaded) {
            return AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: CategoryTile(
                          categoryGradientOne:
                              categoryColors[index % (categoryColors.length)]
                                  ["color1"],
                          categoryGradientTwo:
                              categoryColors[index % (categoryColors.length)]
                                  ["color2"],
                          category: state.data[index],
                          appState: appState,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is CategoriesError) {
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
