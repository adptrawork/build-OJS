// Tandai body saat ?slots=1, supaya outline slot muncul. Tidak berpengaruh di build normal.
if (new URLSearchParams(location.search).has('slots')) {
    document.body.classList.add('akdisi-slots');
}

// Back-to-top button handler.
document.addEventListener('DOMContentLoaded', function () {
    const btn = document.querySelector('.akdisi-back-to-top');
    if (!btn) {
        return;
    }
    btn.addEventListener('click', function () {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
});
