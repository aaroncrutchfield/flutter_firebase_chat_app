import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_app/model/user_data.dart';

class Member {
	static const FIRST_NAME = 'firstName';
	static const LAST_NAME = 'lastName';
	static const EMAIL = 'email';
	static const PHONE_NUMBER = 'phoneNumber';
	static const ADDRESS = 'address';
	static const MEMBER_TYPE = 'memberType';
	static const FAMILY = 'family';

	static const JOINED = 'joined';
	static const MARRIED = 'married';
	static const BIRTHDAY = 'birthday';
	static const BAPTIZED = 'baptized';
	static const HOLY_GHOST = 'holyGhost';
	static const MINISTRIES = 'ministries';

	static const SUNDAY_SERVICES = 'sundayServices';
	static const WEDNESDAY_SERVICES = 'wednesdayServices';
	static const PRAYER_NIGHTS = 'prayerNights';
	static const CHURCH_EVENTS = 'churchEvents';
	static const MINISTRY_EVENTS = 'ministryEvents';

	String id;
	String firstName;
	String lastName;
	String email;
	String phoneNumber;
	String address;
	String memberType;
	List family;

	Timestamp joined;
	Timestamp married;
	Timestamp birthday;
	Timestamp baptized;
	Timestamp holyGhost;
	List ministries;

	List sundayServices;
	List wednesdayServices;
	List prayerNights;
	List churchEvents;
	List ministryEvents;

	Member({
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.address,
      this.memberType,
      this.family,
      this.joined,
      this.married,
      this.birthday,
      this.baptized,
      this.holyGhost,
      this.ministries,
      this.sundayServices,
			this.wednesdayServices,
      this.prayerNights,
      this.churchEvents,
      this.ministryEvents});

	factory Member.fromFirestore(DocumentSnapshot snapshot) {
		Map data = snapshot.data;

		return Member(
			id: snapshot.documentID,
			firstName: data[FIRST_NAME],
			lastName: data[LAST_NAME],
			email: data[EMAIL],
			phoneNumber: data[PHONE_NUMBER],
			address: data[ADDRESS],
			memberType: data[MEMBER_TYPE],
			family: data[FAMILY],

			joined: data[JOINED],
			married: data[MARRIED],
			birthday: data[BIRTHDAY],
			holyGhost: data[HOLY_GHOST],
			ministries: data[MINISTRIES],

			sundayServices: data[SUNDAY_SERVICES],
			wednesdayServices: data[WEDNESDAY_SERVICES],
			prayerNights: data[PRAYER_NIGHTS],
			churchEvents: data[CHURCH_EVENTS],
			ministryEvents: data[MINISTRY_EVENTS]
		);
	}

	Map<String, dynamic> toMap() {
		return {
			UserData.ID: id,
			FIRST_NAME: firstName,
			LAST_NAME: lastName,
			EMAIL: email,
			PHONE_NUMBER: phoneNumber,
			ADDRESS: address,
			MEMBER_TYPE: memberType,
			FAMILY: family,

			JOINED: joined,
			MARRIED: married,
			BIRTHDAY: birthday,
			HOLY_GHOST: holyGhost,
			MINISTRIES: ministries,

			SUNDAY_SERVICES: sundayServices,
			WEDNESDAY_SERVICES: wednesdayServices,
			PRAYER_NIGHTS: prayerNights,
			CHURCH_EVENTS: churchEvents,
			MINISTRY_EVENTS: ministryEvents
		};
	}
}