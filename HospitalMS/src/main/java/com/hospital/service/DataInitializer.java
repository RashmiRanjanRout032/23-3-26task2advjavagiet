package com.hospital.service;

import com.hospital.model.User;
import com.hospital.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        if (!userRepository.existsByUsername("admin")) {
            userRepository.save(User.builder()
                    .username("admin")
                    .password(passwordEncoder.encode("admin123"))
                    .role(User.Role.ADMIN)
                    .fullName("System Administrator")
                    .email("admin@hospital.com")
                    .build());
            log.info("Default admin user created → username: admin / password: admin123");
        }

        if (!userRepository.existsByUsername("receptionist")) {
            userRepository.save(User.builder()
                    .username("receptionist")
                    .password(passwordEncoder.encode("recep123"))
                    .role(User.Role.RECEPTIONIST)
                    .fullName("Front Desk Receptionist")
                    .email("reception@hospital.com")
                    .build());
            log.info("Default receptionist created → username: receptionist / password: recep123");
        }
    }
}
