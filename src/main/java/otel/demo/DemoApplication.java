package otel.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/")
    public String root() {
        return "otel-java-demo root endpoint";
    }

    @GetMapping("/hello")
    public String hello() {
        return "hello from otel-java-demo";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    @GetMapping("/info")
    public String info() {
        return "otel-java-demo info endpoint";
    }

    @GetMapping("/random")
    public String random() {
        return "Random value: " + Math.random();
    }

    @GetMapping("/error")
    public String error() {
        throw new RuntimeException("This is a test error endpoint");
    }
}