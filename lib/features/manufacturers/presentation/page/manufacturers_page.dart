import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jimmy_test/core/locator.dart';
import 'package:jimmy_test/core/widgets/manufacturer_card.dart';
import 'package:jimmy_test/core/widgets/scroll_controls.dart';
import 'package:jimmy_test/features/manufacturers/presentation/bloc/manufacturers_bloc.dart';
import 'package:jimmy_test/features/manufacturers/presentation/widget/empty_list_error_message.dart';
import 'package:jimmy_test/features/manufacturers/presentation/widget/empty_list_loading.dart';
import 'package:jimmy_test/features/manufacturers/presentation/widget/list_status_overlay.dart';
import 'package:jimmy_test/features/manufacturers/presentation/widget/no_manufacturers_message.dart';

class ManufacturersPage extends StatefulWidget {
  const ManufacturersPage({Key? key}) : super(key: key);

  @override
  _ManufacturersPageState createState() => _ManufacturersPageState();
}

class _ManufacturersPageState extends State<ManufacturersPage> {
  late ManufacturersBloc _bloc;
  late ScrollController _scrollController;

  @override
  void initState() {
    _bloc = locator.get()..add(InitManufacturersPage());
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, ManufacturersState state) {
            if (state.loadedManufacturers.isNotEmpty) {
              return _buildList(state);
            }

            if (state.isLoading) {
              return _buildEmptyLoading();
            }

            if (state.errorState is LoadingError) {
              return _buildEmptyError((state.errorState as LoadingError).message);
            }

            return _buildNoManufacturersMessage();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyLoading() {
    return const EmptyListLoading();
  }

  Widget _buildEmptyError(String errorText) {
    return EmptyListErrorMessage(
      errorMessage: errorText,
      onRetryPressed: () {
        _bloc.add(InitManufacturersPage());
      },
    );
  }

  Widget _buildList(ManufacturersState state) {
    final errorMessage =
        (state.errorState is LoadingError) ? (state as LoadingError).message : null;

    return Stack(
      fit: StackFit.expand,
      children: [
        /// List itself
        ListView.builder(
          controller: _scrollController,
          itemCount: state.loadedManufacturers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: ManufacturerCard(manufacturer: state.loadedManufacturers[index]),
            );
          },
        ),

        /// Scroll controller buttons
        Positioned(
          right: 20,
          bottom: 80,
          child: ScrollControlButtons(
            scrollController: _scrollController,
            hideOffset: const Offset(2, 0),
          ),
        ),

        /// Loader + error overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ListStatusOverlay(
            isLoading: state.isLoading,
            errorMessage: errorMessage,
          ),
        ),
      ],
    );
  }

  Widget _buildNoManufacturersMessage() {
    return NoManufacturersMessage(onRetryPressed: () {
      _bloc.add(InitManufacturersPage());
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentOffset = _scrollController.offset;
    final shouldFetchMore = (currentOffset >= maxScroll * 0.95) && (_bloc.state.canLoadMore);

    /// Trigger loading
    if (shouldFetchMore) {
      _bloc.add(LoadNextPageEvent());
    }
  }
}
