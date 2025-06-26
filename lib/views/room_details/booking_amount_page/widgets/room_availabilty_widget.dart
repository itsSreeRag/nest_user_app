import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:provider/provider.dart';

class RoomAvailabilityWidget extends StatelessWidget {
  final String hotelId;
  final String roomId;
  final RoomModel roomData;

  const RoomAvailabilityWidget({
    super.key,
    required this.hotelId,
    required this.roomId,
    required this.roomData,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        // Show loading indicator while checking availability
        if (bookingProvider.isCheckingAvailability) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('Checking availability...'),
                ],
              ),
            ),
          );
        }

        // Show availability status
        if (bookingProvider.availableRooms != null) {
          final availableRooms = bookingProvider.availableRooms!;
          final totalRooms = int.tryParse(roomData.numberOfRooms) ?? 0;
          final isAvailable = availableRooms > 0;

          return Card(
            color: isAvailable ? Colors.green.shade50 : Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isAvailable ? Icons.check_circle : Icons.cancel,
                        color: isAvailable ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAvailable ? 'Available' : 'Not Available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$availableRooms of $totalRooms rooms available',
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (bookingProvider.requiredRooms != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'You need ${bookingProvider.requiredRooms} rooms',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (!isAvailable) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Please try different dates or reduce the number of guests.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        // Default state - no availability check performed yet
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select dates to check availability',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

/// A more compact version for inline display
class CompactAvailabilityIndicator extends StatelessWidget {
  const CompactAvailabilityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isCheckingAvailability) {
          return const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 8),
              Text('Checking...', style: TextStyle(fontSize: 12)),
            ],
          );
        }

        if (bookingProvider.availableRooms != null) {
          final availableRooms = bookingProvider.availableRooms!;
          final isAvailable = availableRooms > 0;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAvailable ? Icons.check_circle : Icons.cancel,
                color: isAvailable ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                isAvailable ? 'Available ($availableRooms)' : 'Not Available',
                style: TextStyle(
                  fontSize: 12,
                  color: isAvailable ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}