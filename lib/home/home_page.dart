import 'package:demo/app_calendar/app_calendar_one.dart';
import 'package:demo/service/app_date_time_format_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final allEvents = <EventModel>[
    // 29 August - 2 events
    EventModel(
      eventName: 'Firebase Integration',
      eventDate: '2026-08-29T10:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-22T12:10:00.000Z',
    ),
    EventModel(
      eventName: 'API Integration',
      eventDate: '2026-08-29T15:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-22T13:00:00.000Z',
    ),

    // 26 August - 2 events
    EventModel(
      eventName: 'Team Meeting',
      eventDate: '2026-08-26T09:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-21T10:15:00.000Z',
    ),
    EventModel(
      eventName: 'Project Planning',
      eventDate: '2026-08-26T14:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-21T11:00:00.000Z',
    ),
    // 25 August - 3 events
    EventModel(
      eventName: 'Flutter Workshop',
      eventDate: '2026-08-25T10:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-20T09:30:00.000Z',
    ),
    EventModel(
      eventName: 'Team Standup',
      eventDate: '2026-08-25T13:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-20T09:45:00.000Z',
    ),
    EventModel(
      eventName: 'Client Discussion',
      eventDate: '2026-08-25T16:00:00.000Z',
      eventStatus: 'cancelled',
      createdAt: '2026-08-20T10:00:00.000Z',
    ),

    // 27 August - 1 event
    EventModel(
      eventName: 'Backend Discussion',
      eventDate: '2026-08-27T13:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-21T11:30:00.000Z',
    ),

    // 28 August - 3 events
    EventModel(
      eventName: 'Client Meeting',
      eventDate: '2026-08-28T09:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-18T14:20:00.000Z',
    ),
    EventModel(
      eventName: 'UI Design Review',
      eventDate: '2026-08-28T12:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-22T09:45:00.000Z',
    ),
    EventModel(
      eventName: 'Code Review',
      eventDate: '2026-08-28T15:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-22T10:00:00.000Z',
    ),

    // 30 August - 1 event
    EventModel(
      eventName: 'Product Demo',
      eventDate: '2026-08-30T12:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-22T14:00:00.000Z',
    ),

    // 31 August - 3 events
    EventModel(
      eventName: 'Sprint Review',
      eventDate: '2026-08-31T10:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-15T10:00:00.000Z',
    ),
    EventModel(
      eventName: 'Sprint Planning',
      eventDate: '2026-08-31T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-23T08:30:00.000Z',
    ),
    EventModel(
      eventName: 'Team Retrospective',
      eventDate: '2026-08-31T16:30:00.000Z',
      eventStatus: 'cancelled',
      createdAt: '2026-08-23T09:00:00.000Z',
    ),

    // 1 September - 3 events
    EventModel(
      eventName: 'Project Kickoff',
      eventDate: '2026-09-01T09:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-23T08:30:00.000Z',
    ),
    EventModel(
      eventName: 'Development Meeting',
      eventDate: '2026-09-01T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-23T09:30:00.000Z',
    ),
    EventModel(
      eventName: 'QA Discussion',
      eventDate: '2026-09-01T16:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-23T10:00:00.000Z',
    ),

    // 2 September - 1 event
    EventModel(
      eventName: 'Backend Discussion',
      eventDate: '2026-09-02T13:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-23T10:20:00.000Z',
    ),

    // 3 September - 2 events
    EventModel(
      eventName: 'Code Review',
      eventDate: '2026-09-03T11:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-23T11:45:00.000Z',
    ),
    EventModel(
      eventName: 'QA Review',
      eventDate: '2026-09-03T16:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-23T12:00:00.000Z',
    ),

    // 4 September - 3 events
    EventModel(
      eventName: 'Product Demo',
      eventDate: '2026-09-04T09:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-24T09:00:00.000Z',
    ),
    EventModel(
      eventName: 'Client Feedback',
      eventDate: '2026-09-04T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-24T10:00:00.000Z',
    ),
    EventModel(
      eventName: 'Release Planning',
      eventDate: '2026-09-04T17:00:00.000Z',
      eventStatus: 'cancelled',
      createdAt: '2026-08-24T11:00:00.000Z',
    ),

    // 5 September - 1 event
    EventModel(
      eventName: 'Maps Integration',
      eventDate: '2026-09-05T10:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-24T10:30:00.000Z',
    ),

    // 7 September - 2 events
    EventModel(
      eventName: 'Team Lunch',
      eventDate: '2026-09-07T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-24T11:15:00.000Z',
    ),
    EventModel(
      eventName: 'Product Discussion',
      eventDate: '2026-09-07T15:30:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-24T12:00:00.000Z',
    ),

    // 8 September - 3 events
    EventModel(
      eventName: 'Performance Testing',
      eventDate: '2026-09-08T10:30:00.000Z',
      eventStatus: 'cancelled',
      createdAt: '2026-08-20T13:40:00.000Z',
    ),
    EventModel(
      eventName: 'Bug Fixing Session',
      eventDate: '2026-09-08T14:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-20T14:00:00.000Z',
    ),
    EventModel(
      eventName: 'Performance Review',
      eventDate: '2026-09-08T17:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-20T14:30:00.000Z',
    ),

    // 10 September - 1 event
    EventModel(
      eventName: 'App Release Meeting',
      eventDate: '2026-09-10T10:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-25T09:15:00.000Z',
    ),

    // 12 September - 2 events
    EventModel(
      eventName: 'QA Testing',
      eventDate: '2026-09-12T11:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-26T10:00:00.000Z',
    ),
    EventModel(
      eventName: 'Testing Review',
      eventDate: '2026-09-12T15:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-26T11:00:00.000Z',
    ),

    // 15 September - 3 events
    EventModel(
      eventName: 'Client Presentation',
      eventDate: '2026-09-15T09:30:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-27T14:30:00.000Z',
    ),
    EventModel(
      eventName: 'Project Review',
      eventDate: '2026-09-15T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-27T15:00:00.000Z',
    ),
    EventModel(
      eventName: 'Team Discussion',
      eventDate: '2026-09-15T16:30:00.000Z',
      eventStatus: 'cancelled',
      createdAt: '2026-08-27T15:30:00.000Z',
    ),

    // 18 September - 2 events
    EventModel(
      eventName: 'Monthly Meeting',
      eventDate: '2026-09-18T10:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-28T09:45:00.000Z',
    ),
    EventModel(
      eventName: 'Monthly Review',
      eventDate: '2026-09-18T14:30:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-28T10:30:00.000Z',
    ),

    // 22 September - 3 events
    EventModel(
      eventName: 'Project Retrospective',
      eventDate: '2026-09-22T09:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-29T11:20:00.000Z',
    ),
    EventModel(
      eventName: 'Project Planning',
      eventDate: '2026-09-22T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-29T12:00:00.000Z',
    ),
    EventModel(
      eventName: 'Project Closure',
      eventDate: '2026-09-22T17:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-29T13:00:00.000Z',
    ),

    // 30 September - 3 events
    EventModel(
      eventName: 'Product Launch',
      eventDate: '2026-09-30T10:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-30T10:15:00.000Z',
    ),
    EventModel(
      eventName: 'Launch Presentation',
      eventDate: '2026-09-30T13:00:00.000Z',
      eventStatus: 'accepted',
      createdAt: '2026-08-30T11:00:00.000Z',
    ),
    EventModel(
      eventName: 'Launch Celebration',
      eventDate: '2026-09-30T16:00:00.000Z',
      eventStatus: 'completed',
      createdAt: '2026-08-30T11:30:00.000Z',
    ),
  ];
  final todayEventList = <EventModel>[];
  final weekEventList = <EventModel>[];
  final monthEventList = <EventModel>[];
  @override
  void initState() {
    super.initState();
    sortEvents();
    filterAllEventList();
  }

  // sort events based on time
  void sortEvents() {
    allEvents.sort(
      (a, b) =>
          DateTime.parse(a.eventDate).compareTo(DateTime.parse(b.eventDate)),
    );
  }

  // filter out events and add into today,week,month list
  void filterAllEventList() {
    todayEventList.clear();
    weekEventList.clear();
    monthEventList.clear();

    final today = DateTime.now().toLocal();
    final weekStart = DateTime(today.year, today.month, today.day);
    final weekEnd = weekStart.add(const Duration(days: 7));
    final monthStart = DateTime(today.year, today.month, 1);
    final monthEnd = DateTime(today.year, today.month + 1, 1);

    for (EventModel event in allEvents) {
      final eventDate = DateTime.parse(event.eventDate).toLocal();

      // Today filter (matches calendar day)
      if (eventDate.year == today.year &&
          eventDate.month == today.month &&
          eventDate.day == today.day) {
        todayEventList.add(event);
      }

      // Week filter (7 days starting from today)
      if (!eventDate.isBefore(weekStart) && eventDate.isBefore(weekEnd)) {
        weekEventList.add(event);
      }

      // Month filter (current calendar month)
      if (!eventDate.isBefore(monthStart) && eventDate.isBefore(monthEnd)) {
        monthEventList.add(event);
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return const Color(0xFF22C55E);
      case 'completed':
        return const Color(0xFFF59E0B);
      case 'cancelled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  Widget _buildEventList(List<EventModel> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text(
          'No events found',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final statusColor = _getStatusColor(event.eventStatus);
        final formattedDate =
            AppDateTimeFormatService.fomatToDayMonthYear(event.eventDate);
        final formattedTime =
            AppDateTimeFormatService.formatToTime(event.eventDate);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Text(
              event.eventName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '$formattedDate  •  $formattedTime',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                event.eventStatus[0].toUpperCase() +
                    event.eventStatus.substring(1),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                tabAlignment: TabAlignment.fill,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: const Color(0xFF242424),
                dividerColor: const Color(0xFFE6E6E6),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelColor: const Color(0xFF242424),
                unselectedLabelColor: const Color(0xFF757575),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.1,
                ),
                tabs: const [
                  Tab(text: 'Today'),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildEventList(todayEventList),
                    _buildEventList(weekEventList),
                    _buildEventList(monthEventList),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

