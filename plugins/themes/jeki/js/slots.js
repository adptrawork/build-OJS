// Tandai body saat ?slots=1, supaya outline slot muncul. Tidak berpengaruh di build normal.
if (new URLSearchParams(location.search).has('slots')) {
    document.body.classList.add('jeki-slots');
}
