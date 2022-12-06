package app.textqna

import future.keywords.in

default allow = false

default organizer := false

default speaker := false

default event_user := false

delete_permissions := [organizer, speaker]

create_permissions := [organizer, speaker]

get_permissions := [organizer, speaker, event_user]

organizer {
	organization := input.organization_id
	user := input.user_id

	data.organizations[organization].members[user].active == true
}

speaker {
	broadcast := input.organization_id
	user := input.user_id

	data.broadcasts[broadcast].speakers[user].active == true
}

event_user {
	user_id := input.user_id
	event_id := input.event_id
	data.events[event_id].members[user_id].blocked == false
}

has_create_permissions {
	some has_permission in create_permissions
	has_permission
    input.action == "CREATE"
}

has_delete_permissions {
	some has_permission in delete_permissions
	has_permission
    input.action == "DELETE"
}

has_get_permissions {
	some has_permission in get_permissions
	has_permission
    input.action == "GET"
}

allow {
	input.action == "CREATE"
	input.path == "text_qna"
	has_create_permissions == true
}

allow {
	input.action == "GET"
	input.path == "text_qna"
	has_get_permissions == true
}

allow {
	input.action == "DELETE"
	input.path == "text_qna"
	has_delete_permissions == true
}


