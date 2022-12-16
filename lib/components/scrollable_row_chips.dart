import 'package:finanz_app/models/konten.dart';
import 'package:flutter/material.dart';

class ScrollableRowOfChips extends StatefulWidget {
  final List<Konten>? chipListKonten;
  final List<Kategorie>? chipListKategorie;
  final List<bool> selected;
  final void Function(List<bool>) callback;

  const ScrollableRowOfChips({
    Key? key,
    this.chipListKonten,
    this.chipListKategorie,
    required this.selected,
    required this.callback,
  }) : super(key: key);

  @override
  State<ScrollableRowOfChips> createState() => _ScrollableRowOfChipsState();
}

class _ScrollableRowOfChipsState extends State<ScrollableRowOfChips> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.chipListKonten != null
            ? widget.chipListKonten!.length
            : widget.chipListKategorie!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selected[index] = !widget.selected[index];
                    for (var i = 0; i < widget.selected.length; i++) {
                      if (widget.selected[i] && index != i) {
                        widget.selected[i] = false;
                      }
                    }
                  });
                  print(widget.selected);
                  widget.callback(widget.selected);
                },
                child: Chip(
                  backgroundColor: widget.selected[index]
                      ? Color(widget.chipListKonten != null
                          ? widget.chipListKonten![index].color
                          : widget.chipListKategorie![index].color)
                      : Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  side: const BorderSide(color: Colors.black, width: 2),
                  label: Text(widget.chipListKonten != null
                      ? widget.chipListKonten![index].toName()
                      : widget.chipListKategorie![index].name),
                ),
              ),
              const SizedBox(width: 16),
            ],
          );
        },
      ),
    );
  }
}
