import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/models/inv_item_model.dart';
import 'package:grd_proj/screens/widget/inventory_item.dart';
import 'package:grd_proj/screens/widget/text.dart';

class BuildItems extends StatefulWidget {
  final String farmId;
  final int? statue;

  const BuildItems({super.key, required this.farmId, this.statue});

  @override
  State<BuildItems> createState() => _BuildItemsState();
}

class _BuildItemsState extends State<BuildItems> {
  List<InvItemModel>? items;
  ControlBloc? _controlBloc;
  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    _controlBloc!.add(OpenFarmItemsEvent(farmId: widget.farmId));
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: widget.farmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FieldModel>? fields;
    return BlocListener<FieldBloc, FieldState>(
        listener: (context, state) {
          if (state is FieldLoaded) {
            fields = state.fields;
          }
          if (state is FieldEmpty) {
            fields = [];
          } else if (state is FieldFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          }
        },
        child: BlocConsumer<ControlBloc, ControlState>(
          listener: (context, state) {
            if (state is DeleteItemSuccess) {
              _controlBloc!.add(OpenFarmItemsEvent(farmId: widget.farmId));
              ScaffoldMessenger.of(context).clearSnackBars();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item Deleted Successfuly"),
                  ),
                );
              });
            } else if (state is DeleteItemFailure) {
              _controlBloc!.add(OpenFarmItemsEvent(farmId: widget.farmId));

              ScaffoldMessenger.of(context).clearSnackBars();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errMessage),
                  ),
                );
              });
            }
          },
          builder: (context, state) {
            if (state is ViewItemsFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errMessage),
                  ),
                );
              });
            } else if (state is ViewItemsSuccess) {
              if (widget.statue != null) {
                items = state.items
                    .where((item) => item.category == widget.statue)
                    .toList();
              } else {
                items = state.items;
              }
              return Container(
                // color: red,
                // padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
                height: 500,
                width: 400,
                child: items!.isEmpty
                    ? const Center(
                        child: Text('Nothing Found',
                            style: TextStyle(
                              color: Color(0xff1E6930),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "manrope",
                            )),
                      )
                    : CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: items!.length,
                              (context, index) {
                                final item = items![index];
                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 40, left: 10, right: 10),
                                  padding: const EdgeInsets.only(top: 24),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              62, 13, 18, 28),
                                          width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(50, 0, 0, 0),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                text(
                                                    fontSize: 22,
                                                    label: item.name,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTapDown: (TapDownDetails
                                                      details) async {
                                                    final RenderBox overlay =
                                                        Overlay.of(context)
                                                                .context
                                                                .findRenderObject()
                                                            as RenderBox;

                                                    await showMenu(
                                                      context: context,
                                                      position:
                                                          RelativeRect.fromRect(
                                                        details.globalPosition &
                                                            const Size(35, 35),
                                                        Offset.zero &
                                                            overlay.size,
                                                      ),
                                                      items: [
                                                        PopupMenuItem(
                                                          height: 45,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/edit.png",
                                                                height: 24,
                                                                width: 24,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              const Text(
                                                                  'Update'),
                                                            ],
                                                          ),
                                                          onTap: () {
                                                            // handle update
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                          height: 45,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/file.png",
                                                                height: 24,
                                                                width: 24,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              const Text(
                                                                  'Log Change'),
                                                            ],
                                                          ),
                                                          onTap: () {
                                                            // handle log
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                          height: 45,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/delete.png",
                                                                height: 24,
                                                                width: 24,
                                                                color: red,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              const Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red)),
                                                            ],
                                                          ),
                                                          onTap: () {
                                                            _controlBloc!.add(
                                                                DeleteItemEvent(
                                                                    farmId: item
                                                                        .farmId,
                                                                    itemId: item
                                                                        .id));
                                                          },
                                                        ),
                                                      ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      color: Colors.white,
                                                    );
                                                  },
                                                  child: Image.asset(
                                                      "assets/images/mage_dots.png"), // زر الثلاث نقاط
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            text(
                                                fontSize: 16,
                                                label: getCategoryName(
                                                    item.category)!,
                                                fontWeight: FontWeight.w600,
                                                color: textColor2),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      text(
                                                        fontSize: 18,
                                                        label: "Quentity",
                                                        color: textColor2,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      text(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        label:
                                                            "${item.quantity.toString()} ${item.measurementUnit}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 168,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      text(
                                                          fontSize: 18,
                                                          label: "Field",
                                                          color: textColor2),
                                                      const SizedBox(height: 5),
                                                      text(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        label: item.fieldId ==
                                                                null
                                                            ? "Not Assigned"
                                                            : "${getFieldName(fields!, item.fieldId!)}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 460,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 77,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: getLevelColor(
                                                          item.stockLevel),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        item.stockLevel,
                                                        style: const TextStyle(
                                                            color:
                                                                bottomBarColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30),
                                                  text(
                                                      fontSize: 18,
                                                      label:
                                                          item.dayTillExpiry ==
                                                                  null
                                                              ? "Not Specified"
                                                              : item
                                                                  .dayTillExpiry
                                                                  .toString(),
                                                      color: getColor(
                                                          item.dayTillExpiry)),
                                                  const Spacer(),
                                                  GestureDetector(
                                                      onTap: () {},
                                                      child: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: textColor2,
                                                          size: 20)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            } else if (state is ItemEmpty) {
              return const SizedBox(
                  child: Center(
                      child: Text('No Items found',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            color: primaryColor,
                          ))));
            }
            return const SizedBox(
                child: Center(
                    child: CircularProgressIndicator(
              color: primaryColor,
            )));
          },
        ));
  }
}
