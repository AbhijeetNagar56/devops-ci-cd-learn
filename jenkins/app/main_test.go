package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestDefaultHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/test", nil)
	rr := httptest.NewRecorder()

	defaultHandler(rr, req)

	if rr.Code != http.StatusOK {
		t.Errorf("expected status %d; got %d", http.StatusOK, rr.Code)
	}

	expected := "Go Backend: you are at endpoint: /test\n"
	if rr.Body.String() != expected {
		t.Errorf("expected body %q; got %q", expected, rr.Body.String())
	}
}

func TestStatusHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/api/status", nil)
	rr := httptest.NewRecorder()

	statusHandler(rr, req)

	if rr.Code != http.StatusOK {
		t.Errorf("expected status %d; got %d", http.StatusOK, rr.Code)
	}

	expected := "Status: online"
	if rr.Body.String() != expected {
		t.Errorf("expected body %q; got %q", expected, rr.Body.String())
	}
}

func TestGreetHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/api/greet", nil)
	rr := httptest.NewRecorder()

	greetHandler(rr, req)

	if rr.Code != http.StatusOK {
		t.Errorf("expected status %d; got %d", http.StatusOK, rr.Code)
	}

	expected := "hello World"
	if rr.Body.String() != expected {
		t.Errorf("expected body %q; got %q", expected, rr.Body.String())
	}
}
