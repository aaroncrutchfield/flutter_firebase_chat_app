import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerDetails {
	static const DETAILS = 'details';
	static const UPDATE_DATE = 'update_date';

	String details;
	Timestamp updateDate;

	PrayerDetails({this.details, this.updateDate});

	factory PrayerDetails.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return PrayerDetails(
			details: data[DETAILS],
			updateDate: data[UPDATE_DATE]
		);
	}

	Map<String, dynamic> toMap() {
		return {
			DETAILS: details,
			UPDATE_DATE: Timestamp.now(),
		};
	}
}