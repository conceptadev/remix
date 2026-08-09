import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:remix/remix.dart';

import 'preview_helper.dart';

@Preview(name: 'Basic Card', size: Size(400, 300))
Widget previewBasicCard() {
  return createRemixPreview(
    const SizedBox(
      width: 350,
      child: RemixCard(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Text(
                'Card Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This is a basic card component with some content inside. Cards are great for grouping related information.',
                style: TextStyle(fontSize: 14, color: MixColors.grey),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

@Preview(name: 'Card with Actions', size: Size(400, 350))
Widget previewCardWithActions() {
  return createRemixPreview(
    const SizedBox(
      width: 350,
      child: RemixCard(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Row(
                children: [
                  Icon(Icons.article, color: MixColors.blue),
                  SizedBox(width: 12),
                  Text(
                    'Article Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(fontSize: 14, color: MixColors.grey),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: .end,
                children: [
                  RemixButton(label: 'Cancel', onPressed: null),
                  SizedBox(width: 8),
                  RemixButton(label: 'Read More', onPressed: null),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

@Preview(name: 'Profile Card', size: Size(400, 400))
Widget previewProfileCard() {
  return createRemixPreview(
    const SizedBox(
      width: 350,
      child: RemixCard(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: .min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: MixColors.blue,
                child: Icon(Icons.person, size: 40, color: MixColors.white),
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Software Developer',
                style: TextStyle(fontSize: 16, color: MixColors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Passionate about creating amazing user experiences and building scalable applications.',
                textAlign: .center,
                style: TextStyle(fontSize: 14, color: MixColors.grey),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: .center,
                children: [
                  RemixIconButton(icon: Icons.email, onPressed: null),
                  SizedBox(width: 12),
                  RemixIconButton(icon: Icons.phone, onPressed: null),
                  SizedBox(width: 12),
                  RemixIconButton(icon: Icons.message, onPressed: null),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

@Preview(name: 'Stats Card', size: Size(400, 250))
Widget previewStatsCard() {
  return createRemixPreview(
    const SizedBox(
      width: 350,
      child: RemixCard(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Dashboard Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '1,234',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MixColors.blue,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Users',
                        style: TextStyle(fontSize: 12, color: MixColors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '567',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MixColors.green,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Orders',
                        style: TextStyle(fontSize: 12, color: MixColors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '\$89,012',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MixColors.orange,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Revenue',
                        style: TextStyle(fontSize: 12, color: MixColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
