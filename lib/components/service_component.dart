import 'package:curdy/model/service_model.dart';
import 'package:flutter/material.dart';

Widget buildServiceItem(
    ServiceItem item,
    double Function(double) scaleX,
    double Function(double) scaleY,
    ThemeData theme,
  ) {
    return Container(
      width: scaleX(70),
      margin: EdgeInsets.only(right: scaleX(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Add this
        children: [
          Container(
            width: scaleX(70),
            height: scaleY(70),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(scaleX(12)),
                child: Image.asset(
                  height: 50,
                  width: 50,
                  item.asset,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image,
                          color: Colors.grey.shade400,
                          size: scaleY(24),
                        ),
                      ),
                ),
              ),
            ),
          ),
          SizedBox(height: scaleY(4)), // Reduced from 8
          Flexible(
            // Wrap text in Flexible
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: scaleY(14).clamp(10.0, 12.0), // Slightly smaller
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,

              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }