package com.hospital.controller;

import com.hospital.model.Appointment;
import com.hospital.service.AppointmentService;
import com.hospital.service.DoctorService;
import com.hospital.service.PatientService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/receptionist")
@RequiredArgsConstructor
public class ReceptionistController {

    private final AppointmentService appointmentService;
    private final DoctorService doctorService;
    private final PatientService patientService;

    // ── Dashboard ──────────────────────────────────────────────────────────────
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("todayAppointments", appointmentService.getTodaysAppointments());
        model.addAttribute("todayCount", appointmentService.countToday());
        model.addAttribute("scheduledCount", appointmentService.countScheduled());
        model.addAttribute("totalCount", appointmentService.countTotal());
        return "receptionist/dashboard";
    }

    // ── APPOINTMENTS ───────────────────────────────────────────────────────────
    @GetMapping("/appointments")
    public String listAppointments(
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
            Model model) {
        if (date != null) {
            model.addAttribute("appointments", appointmentService.getAppointmentsByDate(date));
            model.addAttribute("filterDate", date);
        } else {
            model.addAttribute("appointments", appointmentService.getAllAppointments());
        }
        return "receptionist/appointments";
    }

    @GetMapping("/appointments/add")
    public String addAppointmentForm(Model model) {
        model.addAttribute("appointment", new Appointment());
        model.addAttribute("doctors", doctorService.getActiveDoctors());
        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("pageTitle", "Schedule Appointment");
        return "receptionist/appointmentForm";
    }

    @PostMapping("/appointments/save")
    public String saveAppointment(@Valid @ModelAttribute("appointment") Appointment appointment,
                                  BindingResult result,
                                  RedirectAttributes ra,
                                  Model model) {
        if (result.hasErrors()) {
            model.addAttribute("doctors", doctorService.getActiveDoctors());
            model.addAttribute("patients", patientService.getAllPatients());
            model.addAttribute("pageTitle", appointment.getId() == null ? "Schedule Appointment" : "Edit Appointment");
            return "receptionist/appointmentForm";
        }
        appointmentService.saveAppointment(appointment);
        ra.addFlashAttribute("successMsg", "Appointment saved successfully!");
        return "redirect:/receptionist/appointments";
    }

    @GetMapping("/appointments/edit/{id}")
    public String editAppointmentForm(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return appointmentService.getAppointmentById(id).map(appt -> {
            model.addAttribute("appointment", appt);
            model.addAttribute("doctors", doctorService.getActiveDoctors());
            model.addAttribute("patients", patientService.getAllPatients());
            model.addAttribute("pageTitle", "Edit Appointment");
            return "receptionist/appointmentForm";
        }).orElseGet(() -> {
            ra.addFlashAttribute("errorMsg", "Appointment not found!");
            return "redirect:/receptionist/appointments";
        });
    }

    @GetMapping("/appointments/delete/{id}")
    public String deleteAppointment(@PathVariable Long id, RedirectAttributes ra) {
        appointmentService.deleteAppointmentById(id);
        ra.addFlashAttribute("successMsg", "Appointment deleted.");
        return "redirect:/receptionist/appointments";
    }

    @GetMapping("/appointments/status/{id}/{status}")
    public String updateStatus(@PathVariable Long id,
                               @PathVariable Appointment.Status status,
                               RedirectAttributes ra) {
        appointmentService.getAppointmentById(id).ifPresent(appt -> {
            appt.setStatus(status);
            appointmentService.saveAppointment(appt);
        });
        ra.addFlashAttribute("successMsg", "Status updated to " + status);
        return "redirect:/receptionist/appointments";
    }

    // ── Read-only Doctor & Patient Lists for Receptionist ─────────────────────
    @GetMapping("/doctors")
    public String viewDoctors(Model model) {
        model.addAttribute("doctors", doctorService.getActiveDoctors());
        return "receptionist/doctors";
    }

    @GetMapping("/patients")
    public String viewPatients(Model model) {
        model.addAttribute("patients", patientService.getAllPatients());
        return "receptionist/patients";
    }
}
