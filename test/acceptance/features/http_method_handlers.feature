# language: en

Feature: HTTP method handlers
	In order to customise a RESTful service
	As a developer
	I want to create custom HTTP method handlers

	Scenario: Custom method handlers
		Given I have published a resource with a custom "<method>" handler
		When I perform a HTTP "<method>" request
		Then I should see a status code of "<status>"
		
	Examples:
		| method  | status |
		| GET     | 200    |
		| PUT     | 200    |
		| POST    | 200    |
		| HEAD    | 200    |
		| TRACE   | 200    |
		| DELETE  | 200    |
		| CONNECT | 200    |
		| OPTIONS | 200    |

	Scenario: Default method handlers
		Given I have published a default resource
		When I perform a HTTP "<method>" request
		Then I should see a status code of "<status>"

	Examples:
		| method  | status |
		| GET     | 501    |
		| PUT     | 501    |
		| POST    | 501    |
		| HEAD    | 200    |
		| DELETE  | 501    |
		| CONNECT | 501    |

	Scenario: Default OPTIONS method handler
		Given I have published a default resource
		When I perform a HTTP "TRACE" request
		Then I should see a status code of "200"
		And I should see a "Allow" response header with a value of "TRACE, OPTIONS"

	Scenario: Default TRACE method handler
		Given I have published a default resource
		When I perform a HTTP "TRACE" request
		Then I should see a status code of "200"
		And I should see a "Content-Type" response header with a value of "message/http"
		And I should see a body of "TRACE / HTTP/1.1\r
									Content-Length: 0\n
									Connection: close\n
									Content-Type: application/json; charset=utf-8\n
									Server: Corvusoft - restbed/1.0\n"