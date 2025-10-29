

document.addEventListener('DOMContentLoaded', function() {
    
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

   
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });

    
    animateOnScroll();
    
    
    setupFormValidation();
});


function animateOnScroll() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in-up');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    });

    
    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        observer.observe(el);
    });
}


function setupFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
}


function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    
    notification.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(notification);
    
    
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 5000);
}


function confirmAction(message, callback) {
    if (confirm(message)) {
        callback();
    }
}


function loadContent(url, containerId) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    container.innerHTML = '<div class="text-center"><div class="spinner-border" role="status"><span class="visually-hidden">Cargando...</span></div></div>';
    
    fetch(url)
        .then(response => response.text())
        .then(html => {
            container.innerHTML = html;
        })
        .catch(error => {
            container.innerHTML = '<div class="alert alert-danger">Error al cargar el contenido</div>';
            console.error('Error:', error);
        });
}


function formatNumber(num) {
    return new Intl.NumberFormat('es-AR').format(num);
}


function formatCurrency(amount) {
    return new Intl.NumberFormat('es-AR', {
        style: 'currency',
        currency: 'ARS'
    }).format(amount);
}


function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}


function isValidDNI(dni) {
    const dniRegex = /^\d{7,8}$/;
    return dniRegex.test(dni);
}


function isValidPhone(phone) {
    const phoneRegex = /^(\+54|54)?[\s-]?(\d{2,4})[\s-]?(\d{3,4})[\s-]?(\d{3,4})$/;
    return phoneRegex.test(phone);
}


function handleAjaxError(xhr, status, error) {
    console.error('Error AJAX:', error);
    showNotification('Ocurrió un error inesperado. Por favor, inténtelo nuevamente.', 'danger');
}


function showLoading(element) {
    if (element) {
        element.innerHTML = '<div class="text-center"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Cargando...</span></div></div>';
    }
}


function hideLoading(element, content) {
    if (element) {
        element.innerHTML = content || '';
    }
}


window.TPC = {
    showNotification,
    confirmAction,
    loadContent,
    formatNumber,
    formatCurrency,
    isValidEmail,
    isValidDNI,
    isValidPhone,
    handleAjaxError,
    showLoading,
    hideLoading
};



