package app.textqna

import future.keywords.in

import input.attributes.request.http

default allow = false

allow {http.method == "GET"}
