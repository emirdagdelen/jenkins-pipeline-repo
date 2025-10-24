package com.odinese.auditlog.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class JenkinsController {

    @GetMapping("/jenkins/ok")
    public ResponseEntity<Map<String,Object>> ok() {
        Map<String,Object> response = new HashMap<>();
        response.put("status", "OK");
        response.put("message", "Jenkins is running smoothly.");
        return ResponseEntity.ok(response);
    }

}
