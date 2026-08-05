import 'package:flutter/material.dart';

/// Event model representing schedule status items.
enum EventStatus { confirmed, completed, cancelled }

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  DateTime _focusedDate = DateTime(2025, 7, 16);
  DateTime? _selectedDate = DateTime(2025, 7, 16);

  // Mock events map for status dots and highlights
  final Map<DateTime, List<EventStatus>> _events = {
    DateTime(2025, 7, 14): [EventStatus.confirmed, EventStatus.completed],
    DateTime(2025, 7, 16): [
      EventStatus.cancelled,
      EventStatus.confirmed,
      EventStatus.confirmed,
    ],
    DateTime(2025, 7, 18): [EventStatus.cancelled],
    DateTime(2025, 7, 25): [EventStatus.confirmed],
  };

  // Special highlighted days (light green background like 20 and 27 in screenshot)
  final Set<DateTime> _highlightedDays = {
    DateTime(2025, 7, 20),
    DateTime(2025, 7, 27),
  };

  // ---------------------------------------------------------------------------
  // Helper Utils (Kept on the same page)
  // ---------------------------------------------------------------------------

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<EventStatus> _getEventsForDay(DateTime day) {
    for (var key in _events.keys) {
      if (isSameDay(key, day)) {
        return _events[key]!;
      }
    }
    return [];
  }

  bool _isHighlightedDay(DateTime day) {
    return _highlightedDays.any((d) => isSameDay(d, day));
  }

  void _previousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
    });
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _buildCalendarCard(),
          ),
        ),
      ),
    );
  }

  /// Main Calendar Card Container
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
          _buildMonthHeader(),
          const SizedBox(height: 16),
          _buildWeekdayHeader(),
          const SizedBox(height: 8),
          _buildDaysGrid(),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 14),
          _buildCalendarLegend(),
        ],
      ),
    );
  }

  /// Month & Year Navigation Header (< July 2025 >)
  Widget _buildMonthHeader() {
    final title = '${_getMonthName(_focusedDate.month)} ${_focusedDate.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _previousMonth,
          behavior: HitTestBehavior.opaque,
          child: Container(
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
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        GestureDetector(
          onTap: _nextMonth,
          behavior: HitTestBehavior.opaque,
          child: Container(
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
      ],
    );
  }

  /// Weekday Names Header Row (Sun, Mon, Tue, Wed, Thu, Fri, Sat)
  Widget _buildWeekdayHeader() {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: daysOfWeek.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Grid of Calendar Days
  Widget _buildDaysGrid() {
    final daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayWeekday = DateTime(_focusedDate.year, _focusedDate.month, 1).weekday % 7;

    final totalGridItems = daysInMonth + firstDayWeekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalGridItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        if (index < firstDayWeekday) {
          return const SizedBox.shrink();
        }

        final dayNumber = index - firstDayWeekday + 1;
        final date = DateTime(_focusedDate.year, _focusedDate.month, dayNumber);
        final isSelected = isSameDay(_selectedDate, date);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          child: _buildCustomDayCell(date, isSelected: isSelected),
        );
      },
    );
  }

  /// Custom Cell Builder for Calendar Days
  Widget _buildCustomDayCell(DateTime day, {bool isSelected = false}) {
    final events = _getEventsForDay(day);
    final isHighlighted = _isHighlightedDay(day);

    BoxDecoration decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7D2FE), width: 1),
      );
    } else if (isHighlighted) {
      decoration = BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
      );
    } else {
      decoration = const BoxDecoration();
    }

    Color textColor;
    if (isSelected) {
      textColor = const Color(0xFF1E1B4B);
    } else if (isHighlighted) {
      textColor = const Color(0xFF047857);
    } else {
      textColor = const Color(0xFF374151);
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: decoration,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: (isSelected || isHighlighted)
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: textColor,
              ),
            ),
            if (events.isNotEmpty) ...[
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: events.map((status) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    width: 4.5,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
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
