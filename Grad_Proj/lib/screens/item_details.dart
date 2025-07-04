import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/inv_item_model.dart';
import 'package:grd_proj/screens/widget/inventory_item.dart';
import 'package:grd_proj/screens/widget/text.dart';

class ItemDetails extends StatefulWidget {
  final InvItemModel item;
  final String fieldName;
  const ItemDetails({super.key, required this.item, required this.fieldName});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  text(
                      fontSize: 24,
                      label: "Item Details",
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xff757575), size: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              text(
                  fontSize: 16,
                  label: "Name",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              text(
                  fontSize: 22,
                  label: widget.item.name,
                  fontWeight: FontWeight.w600),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Divider(
                  color: Color.fromARGB(63, 13, 18, 28),
                  thickness: 1,
                ),
              ),
              text(
                  fontSize: 16,
                  label: "Category",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              text(
                  fontSize: 22,
                  label: getCategoryName(widget.item.category)!,
                  fontWeight: FontWeight.w600),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Divider(
                  color: Color.fromARGB(63, 13, 18, 28),
                  thickness: 1,
                ),
              ),
              text(
                  fontSize: 16,
                  label: "Quantity",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              text(
                  fontSize: 22,
                  label: widget.item.quantity.toString(),
                  fontWeight: FontWeight.w600),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Divider(
                  color: Color.fromARGB(63, 13, 18, 28),
                  thickness: 1,
                ),
              ),
              text(
                  fontSize: 16,
                  label: "Stock Level",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 77,
                height: 30,
                decoration: BoxDecoration(
                  color: getLevelColor(widget.item.stockLevel),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    widget.item.stockLevel,
                    style: const TextStyle(
                        color: bottomBarColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Divider(
                  color: Color.fromARGB(63, 13, 18, 28),
                  thickness: 1,
                ),
              ),
              text(
                  fontSize: 16,
                  label: "Expiry",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/mdi_clock-outline.png",
                    height: 21,
                    width: 21,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  text(
                      fontSize: 22,
                      label: widget.item.dayTillExpiry == null
                          ? "Not Specified"
                          : "${widget.item.dayTillExpiry.toString()} days",
                      fontWeight: FontWeight.w600,
                      color: getColor(widget.item.dayTillExpiry)),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Divider(
                  color: Color.fromARGB(63, 13, 18, 28),
                  thickness: 1,
                ),
              ),
              text(
                  fontSize: 16,
                  label: "Field",
                  fontWeight: FontWeight.w600,
                  color: textColor2),
              const SizedBox(
                height: 5,
              ),
              text(
                fontSize: 22,
                label: widget.fieldName,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
