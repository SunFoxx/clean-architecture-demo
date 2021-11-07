import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';
import 'package:jimmy_test/core/locator.dart';
import 'package:jimmy_test/core/theme/theme.dart';
import 'package:jimmy_test/features/makes/presentation/bloc/error_state.dart';
import 'package:jimmy_test/features/makes/presentation/bloc/makes_bloc.dart';
import 'package:jimmy_test/features/makes/presentation/widget/make_card.dart';
import 'package:jimmy_test/features/makes/presentation/widget/makes_error_message.dart';
import 'package:jimmy_test/features/makes/presentation/widget/makes_list_loader.dart';
import 'package:jimmy_test/features/makes/presentation/widget/no_makes_message.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/presentation/widget/manufacturer_card.dart';

class MakesPage extends StatefulWidget {
  final Manufacturer manufacturer;

  const MakesPage({
    Key? key,
    required this.manufacturer,
  }) : super(key: key);

  @override
  _MakesPageState createState() => _MakesPageState();
}

class _MakesPageState extends State<MakesPage> {
  late MakesBloc _bloc;

  @override
  void initState() {
    _bloc = locator.get()..add(LoadMakesFromManufacturer(widget.manufacturer));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.localizedStrings(listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10).copyWith(bottom: 5),
              child: ManufacturerCard(manufacturer: widget.manufacturer),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '–– ${strings.backToManufacturersButtonText} ––',
                  style: AppTheme.typography.mediumIncreasedActive,
                ),
              ),
            ),
            Divider(color: AppTheme.colors.dividerColor),
            Flexible(
              fit: FlexFit.tight,
              child: BlocBuilder(
                bloc: _bloc,
                builder: (context, MakesState state) {
                  if (state.isLoading) {
                    return _buildMakesLoader();
                  }

                  if (state.errorState is LoadingError) {
                    return _buildErrorMessage((state.errorState as LoadingError).message);
                  }

                  if (state.makes.isNotEmpty) {
                    return _buildMakesList(state);
                  }

                  return _buildNoMakesMessage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMakesList(MakesState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: state.makes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        mainAxisExtent: 80,
      ),
      itemBuilder: (context, index) {
        return MakeCard(make: state.makes[index]);
      },
    );
  }

  Widget _buildNoMakesMessage() {
    return NoMakesMessageWidget(
      onRetryPressed: () {
        _bloc.add(LoadMakesFromManufacturer(widget.manufacturer));
      },
    );
  }

  Widget _buildMakesLoader() {
    return const MakesListLoader();
  }

  Widget _buildErrorMessage(String message) {
    return MakesErrorMessage(
      onRetryPressed: () {
        _bloc.add(LoadMakesFromManufacturer(widget.manufacturer));
      },
      errorMessage: message,
    );
  }
}
