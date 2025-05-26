import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/room_detail_info/room_detail_info_items.dart';

class RoomInfoDetailCard extends StatelessWidget {
  final RoomModel roomData;
  const RoomInfoDetailCard({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room Type',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: AppColors.grey600),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            roomData.roomType,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),

                          Text(
                            roomData.roomTypeDescription,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        Icons.apartment,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Room Summary',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppColors.grey600),
                ),
                const SizedBox(height: 4.0),
                Text(
                  roomData.roomDiscription.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const Divider(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomDetailItem(
                      label: 'Room Area',
                      value: roomData.roomArea.toString(),
                      unit: 'ft',
                    ),

                    RoomDetailItem(
                      label: 'Bed Type',
                      value: roomData.bedType.toString(),
                    ),
                    RoomDetailItem(
                      label: 'Number Of beds',
                      value: roomData.numberOfBeds.toString(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoomDetailItem(
                      label: 'Price',
                      value: '₹ ${roomData.basePrice}',
                      valueColors: AppColors.secondary,
                    ),
                    RoomDetailItem(
                      label: 'Adults',
                      value: roomData.maxAdults.toString(),
                    ),
                    RoomDetailItem(
                      label: 'Childrens',
                      value: roomData.maxChildren.toString(),
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
}