    </div><%-- end .page-body --%>
</div><%-- end .main-content --%>

<script>
    // Live date in topbar
    const d = new Date();
    document.getElementById('topbarDate').textContent =
        d.toLocaleDateString('en-IN', { weekday:'long', year:'numeric', month:'long', day:'numeric' });

    // Auto-dismiss alerts after 4 s
    document.querySelectorAll('.alert').forEach(el => {
        setTimeout(() => { el.style.transition='opacity .4s'; el.style.opacity='0';
            setTimeout(() => el.remove(), 400); }, 4000);
    });
</script>
</body>
</html>
