Uri SERVER_IP = Uri.parse('http://10.0.2.2:8085/api/v1');

Uri SERVER_LOGIN = Uri.parse("$SERVER_IP/auth/login");
Uri SERVER_CHANGE_PASSWORD = Uri.parse("$SERVER_IP/auth/password-change");

Uri SERVER_USER = Uri.parse("$SERVER_IP/user");
Uri SERVER_USER_PROFILE = Uri.parse("$SERVER_IP/user/profile");
Uri SERVER_USER_INBOX = Uri.parse("$SERVER_IP/user/read-messages");
Uri SERVER_USER_OUTBOX = Uri.parse("$SERVER_IP/user/send-messages");
Uri SERVER_USER_SEND_MESSAGE = Uri.parse("$SERVER_IP/user/new-message");
Uri SERVER_USER_NOTICES = Uri.parse("$SERVER_IP/user/notices");

Uri SERVER_HEADMASTER_TEACHER = Uri.parse("$SERVER_IP/headmaster/teacher-report/teachers");
Uri SERVER_HEADMASTER_TEACHER_REPORT = Uri.parse("$SERVER_IP/headmaster/teacher-report");
Uri SERVER_HEADMASTER_CLOSE_YEAR = Uri.parse("$SERVER_IP/headmaster/year-closing");
Uri SERVER_HEADMASTER_PAST_YEARS_REPORTS_STUDENTS = Uri.parse("$SERVER_IP/headmaster/end-year-reports/students");
Uri SERVER_HEADMASTER_PAST_YEARS_REPORTS_TEACHERS = Uri.parse("$SERVER_IP/headmaster/end-year-reports/teachers");
Uri SERVER_HEADMASTER_PAST_YEARS = Uri.parse("$SERVER_IP/headmaster/end-year-reports/years");
Uri SERVER_HEADMASTER_PAST_YEARS_REPORTS = Uri.parse("$SERVER_IP/headmaster/end-year-reports");

Uri SERVER_DEPUTY_UNASSIGNED_TEACHERS = Uri.parse("$SERVER_IP/deputy-head/school-classes/unassigned-teachers");
Uri SERVER_DEPUTY_CREATE_CLASS = Uri.parse("$SERVER_IP/deputy-head/school-classes");
Uri SERVER_DEPUTY_CLASS_MANAGEMENT = Uri.parse("$SERVER_IP/deputy-head/school-classes");
Uri SERVER_DEPUTY_CLASS_VIEW = Uri.parse("$SERVER_IP/deputy-head/school-classes");
Uri SERVER_DEPUTY_UNASSIGNED_STUDENTS = Uri.parse("$SERVER_IP/deputy-head/school-classes/unassigned-students");
Uri SERVER_DEPUTY_ADD_STUDENT = Uri.parse("$SERVER_IP/deputy-head/school-classes");
Uri SERVER_DEPUTY_DELETE_CLASS = Uri.parse("$SERVER_IP/deputy-head/school-classes");
Uri SERVER_DEPUTY_CHANGE_TEACHER = Uri.parse("$SERVER_IP/deputy-head/school-classes");
