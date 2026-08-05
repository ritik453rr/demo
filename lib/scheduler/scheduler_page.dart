import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Event model representing schedule status items.
enum EventStatus { confirmed, completed, cancelled }

class SchedulerPage extends StatefulWidget {
  /// Initial focused date when opening calendar
  final DateTime? initialFocusedDay;

  const SchedulerPage({
    super.key,
    this.initialFocusedDay,
  });

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  late DateTime _focusedDay;
  DateTime? _selectedDay;

  late final Map<DateTime, List<EventStatus>> _events;
  late final Set<DateTime> _highlightedDays;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _focusedDay = widget.initialFocusedDay ?? today;
    _selectedDay = _focusedDay;

    _events = {
      today: [
        EventStatus.cancelled,
        EventStatus.confirmed,
        EventStatus.completed,
      ],
      today.add(const Duration(days: 2)): [
        EventStatus.confirmed,
        EventStatus.completed,
      ],
      today.add(const Duration(days: 5)): [EventStatus.cancelled],
      today.add(const Duration(days: 8)): [EventStatus.confirmed],
      today.add(const Duration(days: 12)): [
        EventStatus.completed,
        EventStatus.confirmed,
      ],
      today.add(const Duration(days: 15)): [
        EventStatus.cancelled,
        EventStatus.completed,
      ],
    };

    _highlightedDays = {
      today.add(const Duration(days: 4)),
      today.add(const Duration(days: 11)),
    };
  }

  List<EventStatus> _getEventsForDay(DateTime day) {
    for (var entry in _events.entries) {
      if (isSameDay(entry.key, day)) {
        return entry.value;
      }
    }
    return [];
  }

  bool _isHighlightedDay(DateTime day) {
    return _highlightedDays.any((d) => isSameDay(d, day));
  }

  Color _getStatusColor(EventStatus status) {
    switch (status) {
      case EventStatus.confirmed:
        return const Color(0xFF22C55E); // Green
      case EventStatus.completed:
        return const Color(0xFFF59E0B); // Amber / Yellow
      case EventStatus.cancelled:
        return const Color(0xFFEF4444); // Red
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: SafeArea(
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildCalendarCard(),
        ))
      ),
    );
  } 

  /// Main Calendar Card Container using TableCalendar
  Widget _buildCalendarCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar<EventStatus>(
            firstDay: DateTime.now(), // Calendar Start Limit
            lastDay: DateTime.now().add(
              const Duration(days: 365),
            ), // Calendar End Limit
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
              leftChevronIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Color(0xFF374151),
                  size: 20,
                ),
              ),
              rightChevronIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF374151),
                  size: 20,
                ),
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              weekendStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            calendarStyle: const CalendarStyle(outsideDaysVisible: false),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_isHighlightedDay(day)) {
                  return _buildDayCell(
                    day,
                    backgroundColor: const Color(0xFFECFDF5),
                    textColor: const Color(0xFF047857),
                    isBold: true,
                  );
                }
                return _buildDayCell(day, textColor: const Color(0xFF374151));
              },
              selectedBuilder: (context, day, focusedDay) {
                return _buildDayCell(
                  day,
                  backgroundColor: const Color(0xFFE5E7EB),
                  textColor: const Color(0xFF111827),
                  isBold: true,
                );
              },
              todayBuilder: (context, day, focusedDay) {
                if (isSameDay(_selectedDay, day)) {
                  return _buildDayCell(
                    day,
                    backgroundColor: const Color(0xFFE5E7EB),
                    textColor: const Color(0xFF111827),
                    isBold: true,
                  );
                }
                return _buildDayCell(
                  day,
                  backgroundColor: const Color(0xFFF3F4F6),
                  textColor: const Color(0xFF111827),
                  isBold: true,
                );
              },
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return const SizedBox.shrink();
                return Positioned(
                  bottom: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: events.map((event) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 4.5,
                        height: 4.5,
                        decoration: BoxDecoration(
                          color: _getStatusColor(event),
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 14),
          _buildCalendarLegend(),
        ],
      ),
    );
  }

  Widget _buildDayCell(
    DateTime day, {
    Color? backgroundColor,
    Color? borderColor,
    required Color textColor,
    bool isBold = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }

  /// Calendar Legend Row
  Widget _buildCalendarLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(const Color(0xFF22C55E), "Confirmed"),
        const SizedBox(width: 16),
        _buildLegendItem(const Color(0xFFF59E0B), "Completed"),
        const SizedBox(width: 16),
        _buildLegendItem(const Color(0xFFEF4444), "Cancelled"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
