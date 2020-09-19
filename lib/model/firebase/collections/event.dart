import 'package:cloud_firestore/cloud_firestore.dart';


enum EventTypes {
	SUNDAY_SERVICE,
	WEDNESDAY_SERVICE,
	PRAYER_NIGHT,
	CHURCH_EVENT,
	MINISTRY_EVENT
}

extension EventExtension on EventTypes {
	String get type {
		switch(this) {
			case EventTypes.SUNDAY_SERVICE:
				return 'Sunday Service';
			case EventTypes.WEDNESDAY_SERVICE:
				return 'Wednesday Service';
			case EventTypes.PRAYER_NIGHT:
				return 'Prayer Night';
			case EventTypes.CHURCH_EVENT:
				return 'Church Event';
			case EventTypes.MINISTRY_EVENT:
				return 'Ministry Event';
			default:
				throw UnsupportedError('$this is not a valid type');
		}
	}
	
	static EventTypes fromString(String value) {
		switch(value) {
			case 'Sunday Service':
				return EventTypes.SUNDAY_SERVICE;
			case 'Wednesday Service':
				return EventTypes.WEDNESDAY_SERVICE;
			case 'Prayer Night':
				return EventTypes.PRAYER_NIGHT;
			case 'Church Event':
				return EventTypes.CHURCH_EVENT;
			case 'Ministry Event':
				return EventTypes.MINISTRY_EVENT;
			default:
				throw UnsupportedError('$value is not a valid value');
		}
	}
}


class Event {
	static const DATE_TIME = 'datetime';
	static const TITLE = 'title';
	static const TYPE = 'type';

	String id;
	Timestamp datetime;
	String title;
	EventTypes eventType;

	Event({this.id, this.datetime, this.title, this.eventType});
	
	factory Event.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;
		
		return Event (
			id: snapshot.documentID,
			datetime: data[DATE_TIME],
			title: data[TITLE],
			eventType: EventExtension.fromString(data[TYPE])
		);
	}
	
	Map<String, dynamic> toMap() {
		return {
			DATE_TIME: datetime,
			TITLE: title,
			TYPE: eventType.type
		};
	}
}