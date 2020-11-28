import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/combo_bloc.dart';
import 'package:ecapp/components/combo_product_item.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/models/response/combo_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ComboList extends StatefulWidget {
  String storeSlug;

  ComboBloc comboBloc;

  ComboList({Key key, this.storeSlug}) {
    comboBloc = ComboBloc();
  }

  @override
  _ComboListState createState() => _ComboListState();
}

class _ComboListState extends State<ComboList> {
  int page = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    widget.comboBloc.storeSlug.value = widget.storeSlug;
    widget.comboBloc..getComboProducts();
  }

  @override
  void dispose() {
    super.dispose();
    widget.comboBloc.drainComboStream();
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition > triggerFetchMoreSize) {
        Meta meta = widget.comboBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          widget.comboBloc.page.value = page;
          widget.comboBloc..getComboProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ComboResponse>(
      stream: widget.comboBloc.subject.stream,
      builder: (context, AsyncSnapshot<ComboResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildComboProductsListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildComboProductsListWidget(ComboResponse data) {
    List<Combo> combos = data.combos;
    return Scaffold(
      body: combos.length > 0
          ? Container(
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: combos.length,
                  itemBuilder: (context, index) {
                    return ComboProductItem(combo: combos[index], width: 200.0);
                  }))
          : Center(
              child: Text(tr("No Products Found")),
            ),
    );
  }
}
