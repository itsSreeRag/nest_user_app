import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/room_provider/room_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/room_details/room_details_main.dart';
import 'package:nest_user_app/widgets/room_card.dart';
import 'package:provider/provider.dart';

class HotelAvailableRoomsList extends StatelessWidget {
  final HotelModel hotelData;

  const HotelAvailableRoomsList({super.key, required this.hotelData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // ignore: use_build_context_synchronously
      future: Future.microtask(() => Provider.of<RoomProvider>(context, listen: false).fetchRoomsForHotel(hotelData.uid)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Failed to load rooms",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return Consumer<RoomProvider>(
          builder: (context, roomProvider, child) {
            if (roomProvider.rooms.isEmpty) {
              return const Center(
                child: Text(
                  "No rooms available",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Rooms',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomProvider.rooms.length,
                      itemBuilder: (context, index) {
                        final room = roomProvider.rooms[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomDetailsMain(
                                  roomId: room.roomId!,
                                  hotelData: hotelData,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoomCard(room: room, rating: 4),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
