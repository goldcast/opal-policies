package app.textqna

import future.keywords.in

default allow = false

default is_user_organizer := false

default is_user_speaker := false

default is_user_event_user := false

default is_textqna_event_user := false

default is_broadcast_event_user := false 

default text_qna_creator := false

default text_qna_speaker := false

default text_qna_organizer := false

delete_permissions := [is_user_organizer, is_user_speaker, text_qna_speaker, text_qna_organizer, text_qna_creator]

create_permissions := [is_user_event_user, is_broadcast_event_user]

update_permission := [text_qna_creator]

get_permissions := [is_broadcast_event_user, is_textqna_event_user, is_user_organizer, is_user_speaker, text_qna_organizer, text_qna_speaker, is_user_event_user]

answering_permissions := [is_user_organizer, is_user_speaker, text_qna_organizer, text_qna_speaker]

is_user_organizer {
	organization := input.organization_id
	user := input.user_id
	data.organizations[organization].members[user].active == true
}

is_user_speaker {
	broadcast := input.broadcast_id
	user := input.user_id
	data.broadcasts[broadcast].speakers[user].active == true
}

text_qna_creator {
	user_id := input.user_id
	textqna_id := input.textqna_id
	data.textqnas[textqna_id].owner[user_id].active == true
}

text_qna_organizer {
	textqna_id := input.textqna_id
	user := input.user_id
	broadcast := data.textqnas[textqna_id].broadcast
	organization := data.broadcasts[broadcast].organization
	data.organizations[organization].members[user].active == true
}

text_qna_speaker {
	textqna_id := input.textqna_id
	user := input.user_id
	broadcast := data.textqnas[textqna_id].broadcast
	data.broadcasts[broadcast].speakers[user].active == true
}

is_user_event_user {
	user_id := input.user_id
	event := input.event_id
	data.events[event].members[user_id].blocked == false
}

is_broadcast_event_user {
	user_id := input.user_id
	broadcast_id := input.broadcast_id
    event_id := data.broadcasts[broadcast_id].event
	data.events[event_id].members[user_id].blocked == false
}

is_textqna_event_user {
	user_id := input.user_id
    text_qna_id := input.textqna_id
	broadcast_id := data.textqnas[text_qna_id].broadcast
    event_id := data.broadcasts[broadcast_id].event
	result := data.events[event_id].members[user_id].blocked
    result == false
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
	input.action == "READ"
}

has_answering_permission {
	some has_permission in answering_permissions
	has_permission
}

allow {
	input.path == "text_qna"
	has_create_permissions
}

allow {
	input.path == "text_qna"
	has_get_permissions
}

allow {
	input.path == "text_qna"
	has_delete_permissions
}

allow {
	input.path == "upvote"
	some has_permission in get_permissions
	has_permission
	input.action == "CREATE"
}

allow {
	input.path == "answer"
    has_answering_permission
}
