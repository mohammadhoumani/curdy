import 'package:curdy/components/service_component.dart';
import 'package:curdy/model/service_model.dart';
import 'package:flutter/material.dart';

Widget buildCategorySection({
  required BuildContext context,
  required String title,
  required List<ServiceItem> items,
  required double Function(double) scaleX,
  required double Function(double) scaleY,
  required ThemeData theme,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleX(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: scaleY(18).clamp(16.0, 20.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(scaleX(60), scaleY(30)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: scaleY(14).clamp(12.0, 16.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: scaleX(4)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: theme.colorScheme.primary,
                    size: scaleY(12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: scaleY(3)),
      SizedBox(
        height: scaleY(150).clamp(100.0, 150.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: scaleY(8)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF3F3F3),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: scaleX(16)),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return buildServiceItem(items[index], scaleX, scaleY, theme);
              },
            ),
          ),
        ),
      ),
    ],
  );
}
