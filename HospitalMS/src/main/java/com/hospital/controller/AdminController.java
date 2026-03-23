package com.hospital.controller;

import com.hospital.model.Doctor;
import com.hospital.model.Patient;
import com.hospital.service.AppointmentService;
import com.hospital.service.DoctorService;
import com.hospital.service.PatientService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final DoctorService doctorService;
    private final PatientService patientService;
    private final AppointmentService appointmentService;

    // ── Dashboard ──────────────────────────────────────────────────────────────
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalDoctors", doctorService.countTotal());
        model.addAttribute("activeDoctors", doctorService.countActive());
        model.addAttribute("totalPatients", patientService.countTotal());
        model.addAttribute("totalAppointments", appointmentService.countTotal());
        model.addAttribute("todayAppointments", appointmentService.countToday());
        model.addAttribute("scheduledAppointments", appointmentService.countScheduled());
        model.addAttribute("recentAppointments", appointmentService.getAllAppointments()
                .stream().limit(5).toList());
        return "admin/dashboard";
    }

    // ── DOCTORS ────────────────────────────────────────────────────────────────
    @GetMapping("/doctors")
    public String listDoctors(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isBlank()) {
            model.addAttribute("doctors", doctorService.searchByName(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("doctors", doctorService.getAllDoctors());
        }
        return "admin/doctors";
    }

    @GetMapping("/doctors/add")
    public String addDoctorForm(Model model) {
        model.addAttribute("doctor", new Doctor());
        model.addAttribute("pageTitle", "Add Doctor");
        return "admin/doctorForm";
    }

    @PostMapping("/doctors/save")
    public String saveDoctor(@Valid @ModelAttribute("doctor") Doctor doctor,
                             BindingResult result,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (result.hasErrors()) {
            model.addAttribute("pageTitle", doctor.getId() == null ? "Add Doctor" : "Edit Doctor");
            return "admin/doctorForm";
        }
        doctorService.saveDoctor(doctor);
        redirectAttributes.addFlashAttribute("successMsg",
                "Doctor " + doctor.getName() + " saved successfully!");
        return "redirect:/admin/doctors";
    }

    @GetMapping("/doctors/edit/{id}")
    public String editDoctorForm(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return doctorService.getDoctorById(id).map(doctor -> {
            model.addAttribute("doctor", doctor);
            model.addAttribute("pageTitle", "Edit Doctor");
            return "admin/doctorForm";
        }).orElseGet(() -> {
            ra.addFlashAttribute("errorMsg", "Doctor not found!");
            return "redirect:/admin/doctors";
        });
    }

    @GetMapping("/doctors/delete/{id}")
    public String deleteDoctor(@PathVariable Long id, RedirectAttributes ra) {
        doctorService.deleteDoctorById(id);
        ra.addFlashAttribute("successMsg", "Doctor deleted successfully.");
        return "redirect:/admin/doctors";
    }

    @GetMapping("/doctors/view/{id}")
    public String viewDoctor(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return doctorService.getDoctorById(id).map(doctor -> {
            model.addAttribute("doctor", doctor);
            return "admin/doctorView";
        }).orElseGet(() -> {
            ra.addFlashAttribute("errorMsg", "Doctor not found!");
            return "redirect:/admin/doctors";
        });
    }

    // ── PATIENTS ───────────────────────────────────────────────────────────────
    @GetMapping("/patients")
    public String listPatients(@RequestParam(required = false) String search, Model model) {
        if (search != null && !search.isBlank()) {
            model.addAttribute("patients", patientService.searchByName(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("patients", patientService.getAllPatients());
        }
        return "admin/patients";
    }

    @GetMapping("/patients/add")
    public String addPatientForm(Model model) {
        model.addAttribute("patient", new Patient());
        model.addAttribute("pageTitle", "Add Patient");
        return "admin/patientForm";
    }

    @PostMapping("/patients/save")
    public String savePatient(@Valid @ModelAttribute("patient") Patient patient,
                              BindingResult result,
                              RedirectAttributes redirectAttributes,
                              Model model) {
        if (result.hasErrors()) {
            model.addAttribute("pageTitle", patient.getId() == null ? "Add Patient" : "Edit Patient");
            return "admin/patientForm";
        }
        patientService.savePatient(patient);
        redirectAttributes.addFlashAttribute("successMsg",
                "Patient " + patient.getName() + " saved successfully!");
        return "redirect:/admin/patients";
    }

    @GetMapping("/patients/edit/{id}")
    public String editPatientForm(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return patientService.getPatientById(id).map(patient -> {
            model.addAttribute("patient", patient);
            model.addAttribute("pageTitle", "Edit Patient");
            return "admin/patientForm";
        }).orElseGet(() -> {
            ra.addFlashAttribute("errorMsg", "Patient not found!");
            return "redirect:/admin/patients";
        });
    }

    @GetMapping("/patients/delete/{id}")
    public String deletePatient(@PathVariable Long id, RedirectAttributes ra) {
        patientService.deletePatientById(id);
        ra.addFlashAttribute("successMsg", "Patient deleted successfully.");
        return "redirect:/admin/patients";
    }

    @GetMapping("/patients/view/{id}")
    public String viewPatient(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return patientService.getPatientById(id).map(patient -> {
            model.addAttribute("patient", patient);
            return "admin/patientView";
        }).orElseGet(() -> {
            ra.addFlashAttribute("errorMsg", "Patient not found!");
            return "redirect:/admin/patients";
        });
    }
}
