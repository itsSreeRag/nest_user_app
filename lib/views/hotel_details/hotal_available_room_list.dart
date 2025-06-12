import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/room_provider/room_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/room_details/room_details_main.dart';
import 'package:nest_user_app/widgets/room_card.dart';
import 'package:provider/provider.dart';

class HotelAvailableRoomsList extends StatefulWidget {
  final HotelModel hotelData;

  const HotelAvailableRoomsList({super.key, required this.hotelData});

  @override
  State<HotelAvailableRoomsList> createState() =>
      _HotelAvailableRoomsListState();
}

class _HotelAvailableRoomsListState extends State<HotelAvailableRoomsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomProvider>().fetchRoomsForHotel(widget.hotelData.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Rooms',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Consumer<RoomProvider>(
            builder: (context, roomProvider, child) {
              if (roomProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (roomProvider.rooms.isEmpty) {
                return const Center(
                  child: Text(
                    "No rooms available",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return SizedBox(
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
                            builder:
                                (context) => RoomDetailsMain(
                                  roomId: room.roomId!,
                                  hotelData: widget.hotelData,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
