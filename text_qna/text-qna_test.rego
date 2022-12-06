package app.textqna

import future.keywords.in

textqnadata := {
    "organizations": {
        "organization_1": {
            "members": {
                "org_member_1": {
                    "active": true
                },
                "org_member_2": {
                    "active": true
                }
            }
        },
        "organization_2": {
            "members": {
                "org_member_3": {
                    "active": true
                },
                "org_member_4": {
                    "active": true
                }
            }
        }
    },
    "events": {
        "event_1": {
            "members": {
                "event_member_1": {
                    "blocked": false
                },
                "event_member_2": {
                    "blocked": false
                }
            }
        }
    },
    "broadcasts": {
        "broadcast_1": {
            "event":"event_1",
            "organization":"organization_1",
            "speakers": {
                "speaker_1": {
                    "active": true
                },
                "speaker_2": {
                    "active": true
                }
            }
        }
    },
    "textqnas": {
        "text_qna_1": {
            "owner": {
                "event_member_2" : {
                    "active": true
                }
            },
            "broadcast": "broadcast_1"
        }
    }
}

test_event_user_can_create_text_qna {
    allow with input as {
        "user_id": "event_member_1",
        "broadcast_id": "broadcast_1",
        "action": "CREATE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_organizer_cannot_create_text_qna {
    not allow with input as {
        "user_id": "org_member_1",
        "broadcast_id": "broadcast_1",
        "action": "CREATE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_speaker_cannot_create_text_qna {
    not allow with input as {
        "user_id": "speaker_1",
        "broadcast_id": "broadcast_1",
        "action": "CREATE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_event_user_can_read_text_qna {
    allow with input as {
        "user_id": "event_member_1",
        "textqna_id": "text_qna_1",
        "action": "READ",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_organizer_can_read_text_qna {
    allow with input as {
        "user_id": "org_member_1",
        "textqna_id": "text_qna_1",
        "action": "READ",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_speaker_can_read_text_qna {
    allow with input as {
        "user_id": "speaker_1",
        "textqna_id": "text_qna_1",
        "action": "READ",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_text_qna_creator_can_delete_text_qna {
    allow with input as {
        "user_id": "event_member_2",
        "textqna_id": "text_qna_1",
        "action": "DELETE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_organizer_can_delete_text_qna {
    allow with input as {
        "user_id": "org_member_1",
        "textqna_id": "text_qna_1",
        "action": "DELETE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_speaker_can_delete_text_qna {
    allow with input as {
        "user_id": "speaker_1",
        "textqna_id": "text_qna_1",
        "action": "DELETE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_event_user_cannot_delete_text_qna {
    not allow with input as {
        "user_id": "event_member_1",
        "textqna_id": "text_qna_1",
        "action": "DELETE",
        "path": "text_qna"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_event_user_can_upvote {
    allow with input as {
        "user_id": "event_member_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "upvote"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_organizer_can_upvote {
    allow with input as {
        "user_id": "org_member_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "upvote"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_speaker_can_upvote {
    allow with input as {
        "user_id": "speaker_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "upvote"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_text_qna_creator_can_upvote {
    allow with input as {
        "user_id": "event_member_2",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "upvote"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_organizer_can_answer {
    allow with input as {
        "user_id": "org_member_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "answer"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_speaker_can_answer {
    allow with input as {
        "user_id": "speaker_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "answer"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_text_qna_creator_cannot_answer {
    not allow with input as {
        "user_id": "event_member_2",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "answer"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_event_user_cannot_answer {
    not allow with input as {
        "user_id": "event_member_1",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "answer"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

test_other_org_user_cannot_answer {
    not allow with input as {
        "user_id": "org_member_3",
        "textqna_id": "text_qna_1",
        "action": "CREATE",
        "path": "answer"
    } with data.organizations as textqnadata.organizations with data.events as textqnadata.events with data.broadcasts as textqnadata.broadcasts with data.textqnas as textqnadata.textqnas
}

