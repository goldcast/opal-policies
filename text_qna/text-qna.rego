package app.textqna

import future.keywords.in

import input.attributes.request.http as http_request

import input.parsed_body as request_body

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

user := {"id": user_id} {
	[_, encoded] := split(http_request.headers.authorization, " ")
	[_, payload, _] := io.jwt.decode(encoded)
	user_id := payload.user_id
}

get_path_variable := {"id": id} {
    parts :=split(http_request.path, "/")
    reversed_parts :=  array.reverse(parts)
    id := reversed_parts[0]
}

is_user_organizer {
	organization := request_body.organization_id
	data.organizations[organization].members[user.id].active == true
}

is_user_speaker {
	broadcast := request_body.broadcast_id
	data.broadcasts[broadcast].speakers[user.id].active == true
}

text_qna_creator {
	textqna_id := get_path_variable.id
	data.textqnas[textqna_id].owner[user.id].active == true
}

text_qna_organizer {
	textqna_id := get_path_variable.id
	broadcast := data.textqnas[textqna_id].broadcast
	organization := data.broadcasts[broadcast].organization
	data.organizations[organization].members[user.id].active == true
}

text_qna_speaker {
	textqna_id := get_path_variable.id
	broadcast := data.textqnas[textqna_id].broadcast
	data.broadcasts[broadcast].speakers[user.id].active == true
}

is_user_event_user {
	event := request_body.event_id
	data.events[event].members[user.id].blocked == false
}

is_broadcast_event_user {
	broadcast_id := request_body.broadcast_id
	event_id := data.broadcasts[broadcast_id].event
	data.events[event_id].members[user.id].blocked == false
}

is_textqna_event_user {
	text_qna_id := get_path_variable.id
	broadcast_id := data.textqnas[text_qna_id].broadcast
	event_id := data.broadcasts[broadcast_id].event
	result := data.events[event_id].members[user.id].blocked
	result == false
}

has_create_permissions {
	some has_permission in create_permissions
	has_permission
}

has_delete_permissions {
	some has_permission in delete_permissions
	has_permission
}

has_get_permissions {
	some has_permission in get_permissions
	has_permission
}

has_answering_permission {
	some has_permission in answering_permissions
	has_permission
}

allow {
	http_request.method == "POST"
	http_request.path == "/text_qna"
	has_create_permissions
}

allow {
	http_request.method == "GET"
	startswith(http_request.path, "/text_qna")
	has_get_permissions
}

allow {
	http_request.method == "DELETE"
	startswith(http_request.path, "/text_qna")
	has_delete_permissions
}

allow {
	startswith(http_request.path, "/upvote")
	http_request.method == "POST"
	some has_permission in get_permissions
	has_permission
}

allow {
	startswith(http_request.path, "/answer")
	http_request.method == "POST"
	has_answering_permission
}
